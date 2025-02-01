import 'package:dartz/dartz.dart';
import 'package:groovroads/core/usecase/usecase.dart';
import 'package:groovroads/data/repository/song/songrepoimpl.dart';
import 'package:groovroads/servicelocator.dart';

class AddOrRemoveFavoriteUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepositoryImpl>().addOrRemoveFavorite(params!);
  }
}