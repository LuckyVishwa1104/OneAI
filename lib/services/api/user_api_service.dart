import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/api/network/api_client.dart';
import 'package:one_ai/services/api/network/api_endpoint.dart';

class UserApiService {
  UserApiService({ApiClient? apiClient})
    : _apiClient = apiClient ?? locator<ApiClient>();

  final ApiClient _apiClient;

  // POST /users
  Future<Map<String, dynamic>> createUser({
    required String name,
    required String userId,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _apiClient.dio.post(
      ApiEndpoint.register,
      data: {
        'name': name.trim(),
        'userId': userId.trim(),
        'password': password,
        'confirmPassword': confirmPassword,
      },
    );

    if (response.data is! Map) {
      throw Exception('Invalid registration response from server.');
    }

    return Map<String, dynamic>.from(response.data);
  }
}
