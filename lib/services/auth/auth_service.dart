import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/api/network/api_client.dart';
import 'package:one_ai/services/api/network/api_endpoint.dart';
import 'package:one_ai/services/token_storage_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthMethod { google, apple, manual }

class AuthService {
  AuthService({ApiClient? apiClient, TokenStorageService? tokenStorageService})
    : _apiClient = apiClient ?? locator<ApiClient>(),
      _tokenStorageService =
          tokenStorageService ?? locator<TokenStorageService>();

  final ApiClient _apiClient;
  final TokenStorageService _tokenStorageService;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // ---------------- GOOGLE SIGN-IN ----------------

  Future<User?> signInWithGoogle() async {
    // 1. Sign in with Google.
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final String? googleIdToken = googleAuth.idToken;

    if (googleIdToken == null || googleIdToken.isEmpty) {
      throw const FormatException('Unable to retrieve Google ID token.');
    }

    // 2. Authenticate with Firebase using Google ID token.
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleIdToken,
    );

    final UserCredential userCredential = await _firebaseAuth
        .signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user == null) {
      throw const FormatException('Firebase sign-in did not return a user.');
    }

    // 3. Get Firebase ID token.
    final String? firebaseIdToken = await user.getIdToken();

    // final String? idToken = await user.getIdToken(true);
    // if (idToken != null) {
    //   await Clipboard.setData(ClipboardData(text: idToken));
    //   debugPrint('Token copied. length=${idToken.length}');
    // }

    if (firebaseIdToken == null || firebaseIdToken.isEmpty) {
      throw const FormatException('Unable to retrieve Firebase ID token.');
    }

    // 4. Send Firebase ID token to NestJS.
    final response = await _apiClient.dio.post(
      ApiEndpoint.googleAuth,
      data: {'idToken': firebaseIdToken},
    );

    final responseData = response.data;

    if (responseData is! Map) {
      throw const FormatException(
        'Invalid authentication response from server.',
      );
    }

    final data = Map<String, dynamic>.from(responseData);

    final accessToken = data['accessToken'];

    if (accessToken is! String || accessToken.isEmpty) {
      throw const FormatException(
        'OneAI access token was missing from the response.',
      );
    }

    // 5. Store OneAI JWT securely.
    await _tokenStorageService.saveSession(
      accessToken: accessToken,
      authMethod: AuthMethod.google.name,
    );

    return user;
  }

  // ---------------- APPLE SIGN-IN ----------------

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';

    final random = Random.secure();

    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }

  Future<Map<String, dynamic>> signInWithApple() async {
    // 1. Generate secure raw nonce.
    final rawNonce = _generateNonce();

    // 2. Hash nonce before sending it to Apple.
    final hashedNonce = _sha256ofString(rawNonce);

    // 3. Request Apple credentials.
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    // 4. Retrieve Apple identity token.
    final identityToken = credential.identityToken;

    if (identityToken == null || identityToken.isEmpty) {
      throw const FormatException('Unable to retrieve Apple identity token.');
    }

    // 5. Send Apple credentials to NestJS.
    final response = await _apiClient.dio.post(
      ApiEndpoint.appleAuth,
      data: {
        'identityToken': identityToken,
        'nonce': rawNonce,
        'givenName': credential.givenName,
        'familyName': credential.familyName,
      },
    );

    // 6. Validate backend response.
    if (response.data is! Map) {
      throw const FormatException(
        'Invalid authentication response from server.',
      );
    }

    final responseData = Map<String, dynamic>.from(response.data);

    final accessToken = responseData['accessToken'];

    if (accessToken is! String || accessToken.isEmpty) {
      throw const FormatException(
        'OneAI access token was missing from the response.',
      );
    }

    // 7. Store OneAI JWT securely.
    await _tokenStorageService.saveSession(
      accessToken: accessToken,
      authMethod: AuthMethod.apple.name,
    );

    return responseData;
  }

  // ---------------- MANUAL SIGN-IN ----------------

  Future<Map<String, dynamic>> signInWithPassword({
    required String userId,
    required String password,
  }) async {
    final response = await _apiClient.dio.post(
      ApiEndpoint.login,
      data: {'userId': userId.trim(), 'password': password},
    );

    if (response.data is! Map) {
      throw const FormatException(
        'Invalid authentication response from server.',
      );
    }

    final data = Map<String, dynamic>.from(response.data);

    final accessToken = data['accessToken'];

    if (accessToken is! String || accessToken.isEmpty) {
      throw const FormatException(
        'Access token was missing from the response.',
      );
    }

    // Store OneAI JWT securely.
    await _tokenStorageService.saveSession(
      accessToken: accessToken,
      authMethod: AuthMethod.manual.name,
    );

    return data;
  }

  // ---------------- SIGN OUT ----------------

  Future<void> signOut() async {
    try {
      final authMethod = await _tokenStorageService.getAuthMethod();

      switch (authMethod) {
        case 'google':
          try {
            await _googleSignIn.signOut();
          } finally {
            await _firebaseAuth.signOut();
          }
          break;

        case 'apple':
        // Apple authentication is handled directly
        // through NestJS in the current implementation.
        // No Firebase or Apple SDK sign-out is required.

        case 'manual':
          // No provider SDK sign-out required.
          break;

        default:
          // Fallback for older or incomplete sessions.
          await _firebaseAuth.signOut();
          break;
      }
    } finally {
      // Always attempt to clear OneAI authentication keys.
      await _tokenStorageService.clearSession();
    }
  }

  // ---------------- CURRENT USER ----------------

  User? get currentUser => _firebaseAuth.currentUser;
}
