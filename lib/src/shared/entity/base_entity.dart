import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/shared/dto/base_dto.dart';
import 'package:uuid/uuid.dart';

@AutoMap(target: BaseUserDto)
class BaseUserEntity {
  final String id;
  final DateTime createAt;
  final DateTime? updateAt;
  final DateTime? deletedAt;
  final String? userId;

  BaseUserEntity({
    required this.id,
    required this.createAt,
    required this.updateAt,
    required this.deletedAt,
    required this.userId,
  });

  factory BaseUserEntity.newEntity() {
    final now = DateTime.now();
    return BaseUserEntity(
      id: Uuid().v1(),
      createAt: now,
      updateAt: null,
      deletedAt: null,
      userId: null,
    );
  }
}