class UserEntity {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avaterId;
  final String token;
  final String updatedAt;
  final String createdAt;
  final String id;



  UserEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avaterId,
    required this.token,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
}