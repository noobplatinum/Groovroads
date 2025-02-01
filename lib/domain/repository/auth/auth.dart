import 'package:dartz/dartz.dart';
import 'package:groovroads/data/models/auth/createuser.dart';
import 'package:groovroads/data/models/auth/signinreq.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();
}