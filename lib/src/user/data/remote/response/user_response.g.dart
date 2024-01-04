// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['id'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['name'] as String?,
      json['avatar'] as String?,
      json['is_male'] as bool?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'name': instance.name,
      'avatar': instance.avatar,
      'is_male': instance.isMale,
    };
