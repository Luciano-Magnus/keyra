import 'package:vaden/vaden.dart';

@DTO()
class LoginDto {
  final String token;

  LoginDto({required this.token});
}
