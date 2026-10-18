import 'package:dio/dio.dart';
import 'package:one_ai/services/api/network/api_interceptor.dart';
import 'package:one_ai/services/token_storage_service.dart';

class ApiClient {
  ApiClient(this._tokenStorageService) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:3000',  // 10.120.135.161 - local mac address
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      ApiInterceptor(_tokenStorageService),
    );
  }

  final TokenStorageService _tokenStorageService;

  late final Dio dio;
}