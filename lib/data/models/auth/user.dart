import 'package:groovroads/domain/entities/auth/user.dart';

class UserModel {
  String ? imageURL;
  String ? fullName;
  String ? email;

  UserModel({this.imageURL, this.fullName, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      email: email,
    );
  }
}