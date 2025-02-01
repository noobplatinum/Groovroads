import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/common/helpers/isdarkmode.dart';
import 'package:groovroads/common/widgets/appbar/appbar.dart';
import 'package:groovroads/common/widgets/favbutton/favbutton.dart';
import 'package:groovroads/core/configs/constants/appurls.dart';
import 'package:groovroads/domain/entities/song/song.dart';
import 'package:groovroads/presentation/intro/songplayer/bloc/songplayercubit.dart';
import 'package:groovroads/presentation/intro/songplayer/bloc/songplayerstate.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({required this.songEntity, super.key});

  @override
  Widget build(BuildContext context) {
    final songUrl = '${AppURLs.songFireStorage}${Uri.encodeComponent(songEntity.artist)}%20-%20${Uri.encodeComponent(songEntity.title)}.mp3?alt=media';
    print('Loading song URL: $songUrl'); // Debug print statement

    return Scaffold(
      appBar: Appbar(
        title: Text(
          'Music Player',
          style: TextStyle(
            color: context.isDarkMode ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(songUrl),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            children: [
              songCover(context),
              SizedBox(height: 20),
              songDetails(context),
              SizedBox(height: 15),
              songPlayer(context),
            ],
          ),
        ),
      )
    );
  }

  Widget songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage('${AppURLs.coverFireStorage}${Uri.encodeComponent(songEntity.artist)}%20-%20${Uri.encodeComponent(songEntity.title)}.jpg?alt=media'
        ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget songDetails(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300,
                child: Text(
                  songEntity.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: 200,
                child: Text(
                  songEntity.artist,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        FavButton(songEntity: songEntity)
      ],
    );
  }

  Widget songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>
    (builder: (context, state) {
      if(state is SongPlayerLoading){
        return const CircularProgressIndicator();
      }
      if(state is SongPlayerFailure){
        return Text('Failed to load song');
      }
      if(state is SongPlayerLoaded)
      {
        return Column(
          children: [
            Slider(
              value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
              min: 0.0,
              max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
              onChanged: (value){}
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(
                    context.read<SongPlayerCubit>().songPosition
                  )
                ),

                Text(
                  formatDuration(
                    context.read<SongPlayerCubit>().songDuration
                  )
                ),
              ],
            ),
            const SizedBox(height: 15),

            GestureDetector(
              onTap: (){
                context.read<SongPlayerCubit>().playPauseSong();
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 192, 190, 61),
                ),
                child: Icon(
                context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 35,
                ),
              ),
            )
          ],
        );
      }

      return Container();
    });
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}