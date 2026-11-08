
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  TokenStorageService();

  static const String _accessTokenKey = 'oneai_access_token';
  static const String _authMethodKey = 'oneai_auth_method';

  final FlutterSecureStorage _storage =
      const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async {
    await _storage.write(
      key: _accessTokenKey,
      value: token,
    );
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  Future<bool> hasAccessToken() async {
    return await _storage.containsKey(key: _accessTokenKey);
  }

  // Save authentication method.
  Future<void> saveAuthMethod(String method) async {
    await _storage.write(
      key: _authMethodKey,
      value: method,
    );
  }

  // Retrieve authentication method.
  Future<String?> getAuthMethod() async {
    return _storage.read(key: _authMethodKey);
  }

  // Delete authentication method.
  Future<void> deleteAuthMethod() async {
    await _storage.delete(key: _authMethodKey);
  }

  // Clear complete authentication session.
  Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}
