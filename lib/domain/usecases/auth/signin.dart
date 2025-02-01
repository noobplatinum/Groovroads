import 'package:dartz/dartz.dart';
import 'package:groovroads/core/usecase/usecase.dart';
import 'package:groovroads/data/models/auth/signinreq.dart';
import 'package:groovroads/domain/repository/auth/auth.dart';
import 'package:groovroads/servicelocator.dart';

class SigninUseCase implements UseCase<Either, SigninUserReq> {

  @override
  Future<Either> call({SigninUserReq ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }

}