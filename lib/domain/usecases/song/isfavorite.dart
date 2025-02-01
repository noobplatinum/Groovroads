import 'package:groovroads/core/usecase/usecase.dart';
import 'package:groovroads/data/repository/song/songrepoimpl.dart';
import 'package:groovroads/servicelocator.dart';

class IsFavoriteUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepositoryImpl>().isFavoriteSong(params!);
  }
}