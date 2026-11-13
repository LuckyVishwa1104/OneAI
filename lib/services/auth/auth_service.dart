import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/api/network/api_client.dart';
import 'package:one_ai/services/api/network/api_endpoint.dart';
import 'package:one_ai/services/token_storage_service.dart';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
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

  Future<User?> signInWithGoogle() async {
    try {
      // 1. Sign in with Google.
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final String? googleIdToken = googleAuth.idToken;

      if (googleIdToken == null || googleIdToken.isEmpty) {
        throw Exception('Unable to retrieve Google ID token.');
      }

      // 2. Use the Google ID token to authenticate with Firebase.
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleIdToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Firebase sign-in did not return a user.');
      }

      // 3. Get the Firebase ID token from the authenticated Firebase user.
      final String? firebaseIdToken = await user.getIdToken();

      // final String? idToken = await user.getIdToken(true);
      // if (idToken != null) {
      //   await Clipboard.setData(ClipboardData(text: idToken));
      //   debugPrint('Token copied. length=${idToken.length}');
      // }

      if (firebaseIdToken == null || firebaseIdToken.isEmpty) {
        throw Exception('Unable to retrieve Firebase ID token.');
      }

      // 4. Send the Firebase ID token to NestJS.
      final response = await _apiClient.dio.post(
        ApiEndpoint.googleAuth,
        data: {'idToken': firebaseIdToken},
      );

      final responseData = response.data;

      if (responseData is! Map<String, dynamic>) {
        throw Exception('Invalid authentication response from server.');
      }

      final accessToken = responseData['accessToken'];

      if (accessToken is! String || accessToken.isEmpty) {
        throw Exception('OneAI access token was missing from the response.');
      }

      // 5. Store the OneAI JWT securely.
      await _tokenStorageService.saveAccessToken(accessToken);
      await _tokenStorageService.saveAuthMethod(AuthMethod.google.name);

      return user;
    } on DioException {
      rethrow;
    } on FirebaseAuthException {
      rethrow;
    } on GoogleSignInException {
      rethrow;
    }
  }

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
    try {
      // 1. Generate a secure raw nonce.
      final rawNonce = _generateNonce();

      // 2. Hash the nonce before sending it to Apple.
      final hashedNonce = _sha256ofString(rawNonce);

      // 3. Request Apple credentials.
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      // 4. Retrieve Apple's identity token.
      final identityToken = credential.identityToken;

      if (identityToken == null || identityToken.isEmpty) {
        throw Exception('Unable to retrieve Apple identity token.');
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
        throw Exception('Invalid authentication response from server.');
      }

      final responseData = Map<String, dynamic>.from(response.data);

      final accessToken = responseData['accessToken'];

      if (accessToken is! String || accessToken.isEmpty) {
        throw Exception('OneAI access token was missing from the response.');
      }

      // 7. Store OneAI JWT securely.
      await _tokenStorageService.saveAccessToken(accessToken);
      await _tokenStorageService.saveAuthMethod(AuthMethod.apple.name);

      return responseData;
    } on DioException {
      rethrow;
    } on SignInWithAppleAuthorizationException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signInWithPassword({
    required String userId,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoint.login,
        data: {'userId': userId.trim(), 'password': password},
      );

      if (response.data is! Map) {
        throw Exception('Invalid authentication response from server.');
      }

      final data = Map<String, dynamic>.from(response.data);

      final accessToken = data['accessToken'];

      if (accessToken is! String || accessToken.isEmpty) {
        throw Exception('Access token was missing from the response.');
      }

      await _tokenStorageService.saveAccessToken(accessToken);
      await _tokenStorageService.saveAuthMethod(AuthMethod.manual.name);

      return data;
    } on DioException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    final authMethod = await _tokenStorageService.getAuthMethod();

    try {
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
          break;

        case 'manual':
          // Manual authentication uses only the OneAI JWT.
          break;

        default:
          // Fallback for older sessions without saved provider.
          await _firebaseAuth.signOut();
          break;
      }
    } finally {
      // Always clear the local authentication session,
      // even if provider sign-out encounters an error.
      await _tokenStorageService.deleteAccessToken();
      await _tokenStorageService.deleteAuthMethod();
    }
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
