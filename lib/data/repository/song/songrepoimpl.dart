import 'package:dartz/dartz.dart';
import 'package:groovroads/data/repository/song/failure.dart';
import 'package:groovroads/data/sources/songs/songfirebase.dart';
import 'package:groovroads/domain/entities/song/song.dart';
import 'package:groovroads/domain/repository/song/song.dart';
import 'package:groovroads/servicelocator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either<ServerFailure, List<SongEntity>>> getNewSongs() async {
    print('SongRepositoryImpl.getNewSongs called');
    return await sl<SongFirebaseService>().getNewSongs();
  }
  
  @override
  Future<Either<ServerFailure, List<SongEntity>>> getPlayList() async {
    print('SongRepositoryImpl.getPlayList called');
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavorite(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavorite(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async {
    final result = await sl<SongFirebaseService>().isFavorite(songId);
    return result.fold(
      (failure) => false, 
      (isFavorite) => isFavorite, 
    );
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async {
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
}