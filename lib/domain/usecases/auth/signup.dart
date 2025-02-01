import 'package:dartz/dartz.dart';
import 'package:groovroads/core/usecase/usecase.dart';
import 'package:groovroads/data/models/auth/createuser.dart';
import 'package:groovroads/domain/repository/auth/auth.dart';
import 'package:groovroads/servicelocator.dart';

class SignupUseCase implements UseCase<Either, CreateUserReq> {

  @override
  Future<Either> call({CreateUserReq ? params}) async {
    return sl<AuthRepository>().signup(params!);
  }

}