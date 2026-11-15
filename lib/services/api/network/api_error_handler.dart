import 'package:dio/dio.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  /// Converts API and network exceptions into user-friendly messages.
  static String getMessage(Object error) {
    if (error is DioException) {
      return _handleDioException(error);
    }

    if (error is FormatException) {
      return 'Unable to process the server response. Please try again.';
    }

    if (error is ArgumentError) {
      return 'Invalid information provided. Please check your input.';
    }

    // Do not expose unexpected internal error details to users.
    return 'Something went wrong. Please try again.';
  }

  /// Handles Dio-specific exceptions.
  static String _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please check your internet connection.';

      case DioExceptionType.sendTimeout:
        return 'Request timed out. Please try again.';

      case DioExceptionType.receiveTimeout:
        return 'The server is taking too long to respond. Please try again.';

      case DioExceptionType.transformTimeout:
        return 'Response processing timed out. Please try again.';

      case DioExceptionType.connectionError:
        return 'Unable to connect to the server. Check your internet connection.';

      case DioExceptionType.badCertificate:
        return 'A secure connection could not be established.';

      case DioExceptionType.cancel:
        return 'The request was cancelled.';

      case DioExceptionType.badResponse:
        return _handleServerResponse(error);

      case DioExceptionType.unknown:
        return 'An unexpected network error occurred. Please try again.';
    }
  }

  /// Handles HTTP error responses returned by the backend.
  static String _handleServerResponse(DioException error) {
    final statusCode = error.response?.statusCode;

    switch (statusCode) {
      case 400:
        return _extractValidationMessage(error.response?.data) ??
            'Invalid request. Please check your information.';

      case 401:
        return 'Invalid credentials or expired session.';

      case 403:
        return 'You are not authorized to perform this action.';

      case 404:
        return 'The requested resource was not found.';

      case 409:
        return _extractValidationMessage(error.response?.data) ??
            'This account already exists.';

      case 422:
        return _extractValidationMessage(error.response?.data) ??
            'The submitted information is invalid.';

      case 429:
        return 'Too many requests. Please try again later.';

      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
        return 'Server temporarily unavailable. Please try again later.';

      default:
        return 'Request failed. Please try again.';
    }
  }

  /// Extracts safe validation messages from NestJS responses.
  static String? _extractValidationMessage(dynamic data) {
    if (data is! Map) return null;

    final message = data['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message.trim();
    }

    if (message is List && message.isNotEmpty) {
      final messages =
          message
              .whereType<String>()
              .map((item) => item.trim())
              .where((item) => item.isNotEmpty)
              .toList();

      if (messages.isNotEmpty) {
        return messages.join('\n');
      }
    }

    return null;
  }
}
