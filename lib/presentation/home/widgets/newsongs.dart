import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/common/helpers/isdarkmode.dart';
import 'package:groovroads/core/configs/constants/appurls.dart';
import 'package:groovroads/domain/entities/song/song.dart';
import 'package:groovroads/presentation/home/bloc/newsongscubit.dart';
import 'package:groovroads/presentation/home/bloc/newsongsstate.dart';
import 'package:groovroads/presentation/intro/songplayer/pages/songplayer.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewSongsCubit()..getNewSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewSongsCubit, NewSongsState>(
          builder: (context, state) {
            if (state is NewSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              );
            }

            if (state is NewSongsLoaded) {
              return _songs(state.songs);
            }

            return Container();
          },
        ),
      ),
    );
  }

    Widget _songs(List<SongEntity> songs) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding to the edges
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final song = songs[index];
    
            final imageUrl =
                '${AppURLs.coverFireStorage}${Uri.encodeComponent(song.artist)}%20-%20${Uri.encodeComponent(song.title)}.jpg?alt=media';
    
            debugPrint('Song: ${song.artist} - ${song.title}');
            debugPrint('Image URL: $imageUrl');

            return GestureDetector(
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SongPlayerPage(songEntity: songs[index],)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      width: 180,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 35,
                          width: 35,
                          transform: Matrix4.translationValues(10, 10, 0),
                          child: Icon(Icons.play_arrow_rounded, color: const Color.fromARGB(255, 194, 174, 0),),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode ? Colors.black.withOpacity(0.8) : Colors.white.withOpacity(0.8)
                          ),
                        )
                      )
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 180,
                    child: Text(
                      songs[index].title,
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    songs[index].artist,
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 14),
          itemCount: songs.length,
        ),
      );
    }
}
