
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  TokenStorageService();

  static const String _accessTokenKey = 'oneai_access_token';
  static const String _authMethodKey = 'oneai_auth_method';

  final FlutterSecureStorage _storage =
      const FlutterSecureStorage();

  // Save access token.
  Future<void> saveAccessToken(String token) async {
    if (token.trim().isEmpty) {
      throw ArgumentError('Access token cannot be empty.');
    }

    await _storage.write(
      key: _accessTokenKey,
      value: token,
    );
  }

  // Retrieve access token.
  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  // Check whether a valid-looking token exists.
  Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Save authentication method.
  Future<void> saveAuthMethod(String method) async {
    if (method.trim().isEmpty) {
      throw ArgumentError('Authentication method cannot be empty.');
    }

    await _storage.write(
      key: _authMethodKey,
      value: method,
    );
  }

  // Retrieve authentication method.
  Future<String?> getAuthMethod() async {
    return _storage.read(key: _authMethodKey);
  }

  // Save complete authentication session.
  Future<void> saveSession({
    required String accessToken,
    required String authMethod,
  }) async {
    try {
      await saveAccessToken(accessToken);
      await saveAuthMethod(authMethod);
    } catch (_) {
      // Prevent a partially saved session.
      await clearSession();
      rethrow;
    }
  }

  // Delete access token.
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  // Delete authentication method.
  Future<void> deleteAuthMethod() async {
    await _storage.delete(key: _authMethodKey);
  }

  // Clear only OneAI authentication data.
  Future<void> clearSession() async {
    Object? firstError;
    StackTrace? firstStackTrace;

    try {
      await deleteAccessToken();
    } catch (error, stackTrace) {
      firstError = error;
      firstStackTrace = stackTrace;
    }

    try {
      await deleteAuthMethod();
    } catch (error, stackTrace) {
      firstError ??= error;
      firstStackTrace ??= stackTrace;
    }

    if (firstError != null) {
      Error.throwWithStackTrace(firstError, firstStackTrace!);
    }
  }
}
