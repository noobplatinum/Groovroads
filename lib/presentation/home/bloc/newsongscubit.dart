import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/domain/usecases/song/getnewsongs.dart';
import 'package:groovroads/presentation/home/bloc/newsongsstate.dart';
import 'package:groovroads/servicelocator.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  NewSongsCubit() : super(NewSongsLoading());

  Future<void> getNewSongs() async {
    print('getNewSongs called');
    var returnedSongs = await sl<GetNewSongsUseCase>().call();

    returnedSongs.fold(
      (l) {
        print('Failed to load new songs');
        emit(NewSongsLoadFailure());
      },
      (data) {
        print('New songs loaded: ${data.length}');
        emit(NewSongsLoaded(songs: data));
      }
    );
  }
}