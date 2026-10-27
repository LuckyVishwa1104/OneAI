import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/api/network/api_client.dart';
import 'package:one_ai/services/api/network/api_endpoint.dart';

class UserApiService {
  UserApiService({ApiClient? apiClient})
      : _apiClient = apiClient ?? locator<ApiClient>();

  final ApiClient _apiClient;

  // GET /users
  Future<List<dynamic>> getUsers() async {
    final response = await _apiClient.dio.get(
      ApiEndpoint.users,
    );

    return response.data as List<dynamic>;
  }

  // POST /users
  Future<dynamic> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.dio.post(
      ApiEndpoint.users,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return response.data;
  }
}
