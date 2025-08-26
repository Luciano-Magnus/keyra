
import 'package:vaden/vaden.dart';

extension RequestExtension on Request {
  String? get userId => headers['x-user-id'];
  String? get apiKey => headers['X-API-Key'];
}