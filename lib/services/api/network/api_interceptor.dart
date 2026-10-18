import 'package:dio/dio.dart';
import 'package:one_ai/services/token_storage_service.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor(this._tokenStorageService);

  final TokenStorageService _tokenStorageService;

  static Interceptor verifyType() => ApiInterceptor(TokenStorageService());
  
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _tokenStorageService.getAccessToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      handler.next(options);
    } catch (error, stackTrace) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          stackTrace: stackTrace,
          message: 'Unable to retrieve authentication token',
        ),
      );
    }
  }
}
