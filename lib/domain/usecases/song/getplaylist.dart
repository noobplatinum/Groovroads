import 'package:dartz/dartz.dart';
import 'package:groovroads/core/usecase/usecase.dart';
import 'package:groovroads/data/repository/song/songrepoimpl.dart';
import 'package:groovroads/servicelocator.dart';

class GetPlayListUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({params}) async {
    return sl<SongRepositoryImpl>().getPlayList();
  }

}