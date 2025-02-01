import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/domain/usecases/song/getplaylist.dart';
import 'package:groovroads/presentation/home/bloc/playliststate.dart';
import 'package:groovroads/servicelocator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    print('getPlayList called');
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    returnedSongs.fold(
      (l) {
        print('Failed to load playlist: $l');
        emit(PlayListLoadFailure());
      },
      (data) {
        print('Playlist loaded: ${data.length} songs');
        emit(PlayListLoaded(songs: data));
      }
    );
  }
}