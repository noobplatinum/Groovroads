import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groovroads/data/models/song/song.dart';
import 'package:groovroads/data/repository/song/failure.dart';
import 'package:groovroads/domain/entities/song/song.dart';
import 'package:groovroads/domain/usecases/song/isfavorite.dart';
import 'package:groovroads/servicelocator.dart';

abstract class SongFirebaseService {
  Future<Either<ServerFailure, List<SongEntity>>> getNewSongs();
  Future<Either<ServerFailure, List<SongEntity>>> getPlayList();
  Future<Either<ServerFailure, bool>> addOrRemoveFavorite(String songId);
  Future<Either<ServerFailure, bool>> isFavorite(String songId); 
  Future<Either<ServerFailure, List<SongEntity>>> getUserFavoriteSongs();
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either<ServerFailure, List<SongEntity>>> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releasedate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteUseCase>().call(
          params: element.reference.id
        );
        songModel.isFavorited = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      print('Error in getNewSongs: $e');
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<ServerFailure, List<SongEntity>>> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releasedate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteUseCase>().call(
          params: element.reference.id
        );
        songModel.isFavorited = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      print('Error in getPlayList: $e');
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<ServerFailure, bool>> addOrRemoveFavorite(String songId) async {
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').where('songId', isEqualTo: songId).get();

      if(favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').add({
          'songId': songId,
          'addedDate' : Timestamp.now()
        });
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch(e){
      print('Error in addOrRemoveFavorite: $e');
      return Left(ServerFailure());
    }
  } 

  @override
  Future<Either<ServerFailure, bool>> isFavorite(String songId) async {
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').where('songId', isEqualTo: songId).get();

      if(favoriteSongs.docs.isNotEmpty) {
        isFavorite = true;
      } else {
        isFavorite = false;
      }
      return Right(isFavorite);
    } catch(e){
      print('Error in isFavorite: $e');
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<ServerFailure, List<SongEntity>>> getUserFavoriteSongs() async {
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSongs = [];
      String uId = user!.uid;
      QuerySnapshot favoriteSnapshot = await firebaseFirestore.collection(
        'Users'
      ).doc(uId).collection('Favorites').get();
      
      for(var element in favoriteSnapshot.docs) {
        String songId = element['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorited = true;
        songModel.songId = songId;
        favoriteSongs.add(
          songModel.toEntity()
        );
      }

      return Right(favoriteSongs);

    } catch(e){
      print('Error in getUserFavoriteSongs: $e');
      return Left(ServerFailure());
    }
  }
}