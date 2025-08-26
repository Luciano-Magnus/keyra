import 'dart:async';
import 'dart:convert';

import 'package:keyra/config/di/dependency_injection.dart';
import 'package:keyra/src/shared/database/database.dart';
import 'package:vaden/vaden.dart';

class ApiTokenMiddleware extends VadenMiddleware {
  final Database database = DI.injector<Database>();

  @override
  FutureOr<Response> handler(Request request, Handler handler) async {
    final path = request.url.path;
    final method = request.method;
    final apiToken = request.headers['x-api-token'] ?? request.headers['x-api-key'];

    if (path == 'docs' || path == 'docs/swagger.json') {
      // Allow access to documentation without API token
      return handler(request);
    } else if (path.startsWith('api/v1/user/create') || path.startsWith('api/v1/user/login')) {
      // Allow user registration without API token
      return handler(request);
    } else if (_isAppAccess(path, method, request)) {
      if (apiToken == null || apiToken.isEmpty) {
        return Response.forbidden(jsonEncode({'message': 'Invalid API token'}), headers: {'Content-Type': 'application/json'});
      }

      final users = await database.select(tableName: 'users', where: 'api_token = @token', parameters: {'token': apiToken});

      if (users.isEmpty) {
        return Response.forbidden(jsonEncode({'message': 'Invalid API token'}), headers: {'Content-Type': 'application/json'});
      }

      request = request.change(
        headers: {
          ...request.headers,
          'x-user-id': users.first['id_user'].toString(),
        },
      );
    } else if (path.startsWith('api/v1')) {
      if (apiToken == null || apiToken.isEmpty) {
        return Response.forbidden(jsonEncode({'message': 'Invalid API token'}), headers: {'Content-Type': 'application/json'});
      }

      final users = await database.select(tableName: 'users', where: 'admin_token = @token', parameters: {'token': apiToken});

      if (users.isEmpty) {
        return Response.forbidden(jsonEncode({'message': 'Invalid API token'}), headers: {'Content-Type': 'application/json'});
      }

      request = request.change(
        headers: {
          ...request.headers,
          'x-user-id': users.first['id_user'].toString(),
        },
      );
    }

    return await handler(request);
  }

  bool _isAppAccess(String path, String method, Request request) {
    return (path.startsWith('api/v1/activation') && method == 'POST') || (path.startsWith('api/v1/activation/available') && method == 'GET');
  }
}
