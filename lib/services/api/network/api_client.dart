import 'package:dio/dio.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/api/network/api_interceptor.dart';
import 'package:one_ai/services/token_storage_service.dart';

class ApiClient {
  ApiClient({TokenStorageService? tokenStorageService})
      : _tokenStorageService =
            tokenStorageService ?? locator<TokenStorageService>() {
    dio = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'http://10.0.2.2:3000',
        ),
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(ApiInterceptor(_tokenStorageService));
  }

  final TokenStorageService _tokenStorageService;
  late final Dio dio;
}