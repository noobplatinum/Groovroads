import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/common/helpers/isdarkmode.dart';
import 'package:groovroads/common/widgets/favbutton/favbutton.dart';
import 'package:groovroads/domain/entities/song/song.dart';
import 'package:groovroads/presentation/home/bloc/playlistcubit.dart';
import 'package:groovroads/presentation/home/bloc/playliststate.dart';
import 'package:groovroads/presentation/intro/songplayer/pages/songplayer.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => PlayListCubit()..getPlayList(),
    child: BlocBuilder<PlayListCubit, PlayListState> (
      builder: (context, state) {
        print('Current state: $state');
        if(state is PlayListLoading) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }

        if(state is PlayListLoaded) {
          print('Rendering playlist with ${state.songs.length} songs');
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Playlist',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: songs(state.songs),
              )
            ],
          );
        }

        return Container();
      }
    )
    );
  }

  Widget songs(List<SongEntity> songs)
  {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context,index) {
        return GestureDetector(
        onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SongPlayerPage(songEntity: songs[index],)));
            },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                        ? const Color.fromARGB(255, 59, 59, 59).withOpacity(0.4)
                        : const Color.fromARGB(255, 165, 165, 165).withOpacity(0.3),
                  ),
                  child: Icon(Icons.play_arrow_rounded, color: const Color.fromARGB(255, 194, 174, 0)),
                  ),
                  const SizedBox(width: 10),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 230,
                        child: Text(
                          songs[index].title,
                          style: TextStyle(
                            fontSize: 14,
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
                          songs[index].artist,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: context.isDarkMode ? Colors.white : Colors.black,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(children: [Text(songs[index].duration.toString().replaceAll('.', ':')
              , style: TextStyle(fontWeight: FontWeight.w300),)],
              ),
              const SizedBox(width: 20,),
              FavButton(songEntity: songs[index])
            ]),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 25),
      itemCount: songs.length,
    );
  }
}