import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/presentation/intro/songplayer/bloc/songplayerstate.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration ?? Duration.zero;
    });
  }

  void updateSongPlayer() {
    emit(
      SongPlayerLoaded()
    );
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit (SongPlayerLoaded());
    } catch(e){
      emit (SongPlayerFailure());
    }
  }

  void playPauseSong() {
    if(audioPlayer.playing){
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }

    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}