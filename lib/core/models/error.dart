import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ErrorModel {
  final String? message;
  final int? statusCode;
  final String? code;

  const ErrorModel({this.statusCode, this.message, this.code});

  @override
  ErrorModel.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        statusCode = json['status_code'],
        code = json['code'];

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
        'code': code,
      };

  // Converts firebase error code to the APP error code.
  // If given errorCode isn't firebase error, returns it directly.
  static ErrorModel generate(dynamic errorCode) {
    final errorcases = {
      'user-disabled': 'user-not-found',
      'operation-not-allowed': 'unauthorized',
      'email-already-in-use': 'user-already-exists',
      'email-already-exists': 'user-already-exists',
    };

    return ErrorModel(code: errorcases[errorCode] ?? errorCode);
  }

  // Generates error model from exception.
  static ErrorModel? fromException(dynamic exception) {
    ErrorModel? err;

    if (exception is FirebaseAuthException) {
      err = ErrorModel.generate(exception.code);
    }
    if (exception is DioError) {
      err = ErrorModel.fromJson(exception.response!.data);
    }

    return err;
  }

  // Constant error for no-connection representation.
  static get noConnection =>
      const ErrorModel(statusCode: 400, code: 'no-connection');
}
