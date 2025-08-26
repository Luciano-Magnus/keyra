import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/shared/entity/base_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:vaden_core/vaden_core.dart';

@DTO()
@AutoMap(target: BaseUserEntity)
class BaseUserDto {
  final String id;
  final DateTime createAt;
  final DateTime? updateAt;
  final DateTime? deletedAt;
  String? userId;

  BaseUserDto({
    required this.id,
    required this.createAt,
    required this.updateAt,
    required this.deletedAt,
    required this.userId,
  });

  factory BaseUserDto.newBase() {
    return BaseUserDto(
      id: Uuid().v1(),
      createAt: DateTime.now(),
      updateAt: null,
      deletedAt: null,
      userId: null,
    );
  }
}

class BaseDtoParse extends ParamParse<BaseUserDto, Map<String, dynamic>?> {
  const BaseDtoParse();

  @override
  Map<String, dynamic>? toJson(BaseUserDto param) {
    return {
      'id': param.id,
      'createAt': param.createAt.toIso8601String(),
      'updateAt': param.updateAt?.toIso8601String(),
      'deletedAt': param.deletedAt?.toIso8601String(),
      'userId': param.userId,
    };

  }

  @override
  BaseUserDto fromJson(Map<String, dynamic>? json) {
    if (json == null) return BaseUserDto.newBase();

    return BaseUserDto(
      id: json['id'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: json['updateAt'] != null
          ? DateTime.parse(json['updateAt'] as String)
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
      userId: json['userId'] as String?,
    );
  }
}