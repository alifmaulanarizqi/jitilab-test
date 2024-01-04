class UserResponseDto {
  final String phone;
  final String email;
  final String avatar;
  final String name;
  final String id;

  const UserResponseDto({
    this.phone = '',
    this.email = '',
    this.avatar = '',
    this.name = '',
    this.id = '',
  });

  @override
  String toString() {
    return 'UserResponseDto{lastVisiblePage: $phone, hasNextPage: $email, name: $name, id: $id}';
  }
}