import 'package:dartz/dartz.dart';
import 'package:groovroads/core/usecase/usecase.dart';
import 'package:groovroads/domain/repository/auth/auth.dart';
import 'package:groovroads/servicelocator.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}