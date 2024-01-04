import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'is_male')
  final bool? isMale;

  const UserResponse(
      this.id,
      this.email,
      this.phone,
      this.name,
      this.avatar,
      this.isMale,
      );

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}