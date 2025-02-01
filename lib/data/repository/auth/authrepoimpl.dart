import 'package:dartz/dartz.dart';
import 'package:groovroads/data/models/auth/createuser.dart';
import 'package:groovroads/data/models/auth/signinreq.dart';
import 'package:groovroads/data/sources/auth/auth_firebase.dart';
import 'package:groovroads/domain/repository/auth/auth.dart';
import 'package:groovroads/servicelocator.dart';

class AuthRepositoryImpl extends AuthRepository
{
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }
  
  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }
}