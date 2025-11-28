import 'package:movie_app/auth/domain/entities/user_entity.dart';

class DataModel {
  DataModel({
    this.email,
    this.password,
    this.confirmPassword,
    this.name,
    this.phone,
    this.avaterId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  DataModel.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
  }
  String? email;
  String? password;
  String? confirmPassword;
  String? name;
  String? phone;
  num? avaterId;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? token;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['token'] = token;
    return map;
  }

  UserEntity toEntity() {
    return UserEntity(
      name: name ?? '',
      email: email ?? '',
      password: password ?? '',
      confirmPassword: confirmPassword ?? '',
      phone: phone ?? '',
      avaterId: avaterId?.toInt() ?? 0,
      id: id ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      token: token ?? '',
    );
  }
}
