import 'dart:convert';

import 'package:keyra/src/shared/exceptions/custom/custom_exception.dart';
import 'package:keyra/src/shared/exceptions/not_found/not_found_exception.dart';
import 'package:keyra/src/shared/exceptions/unauthorized/unauthorized_exception.dart';
import 'package:vaden/vaden.dart';

@ControllerAdvice()
class AppControllerAdvice {
  final DSON _dson;

  AppControllerAdvice(this._dson);

  @ExceptionHandler(ResponseException)
  Future<Response> handleResponseException(ResponseException e) async {
    return e.generateResponse(_dson);
  }

  @ExceptionHandler(NotFoundException)
  Response handleNotFoundException(NotFoundException e) {
    return Response.notFound(jsonEncode({'message': e.message}));
  }

  @ExceptionHandler(UnauthorizedException)
  Response handleUnauthorizedException(UnauthorizedException e) {
    return Response.unauthorized({'message': 'Unauthorized'});
  }


  @ExceptionHandler(CustomException)
  Response handleCustomException(CustomException e) {
    return Response(e.code ?? 400, body: jsonEncode({'message': e.message}));
  }

  @ExceptionHandler(Exception)
  Response handleException(Exception e) {
    return Response.internalServerError(body: jsonEncode({'message': 'Internal server error'}));
  }
}
