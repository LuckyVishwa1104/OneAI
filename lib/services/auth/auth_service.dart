import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/api/network/api_client.dart';
import 'package:one_ai/services/api/network/api_endpoint.dart';
import 'package:one_ai/services/token_storage_service.dart';

class AuthService {
  AuthService({
    ApiClient? apiClient,
    TokenStorageService? tokenStorageService,
  })  : _apiClient = apiClient ?? locator<ApiClient>(),
        _tokenStorageService =
            tokenStorageService ?? locator<TokenStorageService>();


  final ApiClient _apiClient;
  final TokenStorageService _tokenStorageService;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // 1. Sign in with Google through Firebase.
      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final String? firebaseIdToken = googleAuth.idToken;

      if (firebaseIdToken == null || firebaseIdToken.isEmpty) {
        throw Exception('Unable to retrieve Firebase ID token.');
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: firebaseIdToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Firebase sign-in did not return a user.');
      }

      // 2. Exchange the Firebase ID token for a OneAI JWT.
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

      // 3. Store the OneAI JWT securely.
      await _tokenStorageService.saveAccessToken(accessToken);

      // 4. Return only after backend authentication and storage succeed.
      return user;
    } on DioException {
      rethrow;
    } on FirebaseAuthException {
      rethrow;
    } on GoogleSignInException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _tokenStorageService.deleteAccessToken();
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
