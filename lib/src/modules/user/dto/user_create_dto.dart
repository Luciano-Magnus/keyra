import 'package:vaden/vaden.dart';

@DTO()
class UserCreateDto {
  final String name;
  final String email;

  UserCreateDto({required this.name, required this.email});
}
