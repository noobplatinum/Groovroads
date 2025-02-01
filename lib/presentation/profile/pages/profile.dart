import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/common/helpers/isdarkmode.dart';
import 'package:groovroads/common/widgets/appbar/appbar.dart';
import 'package:groovroads/common/widgets/favbutton/favbutton.dart';
import 'package:groovroads/presentation/profile/bloc/favoritesongscubit.dart';
import 'package:groovroads/presentation/profile/bloc/favoritesongsstate.dart';
import 'package:groovroads/presentation/profile/bloc/profileinfocubit.dart';
import 'package:groovroads/presentation/profile/bloc/profileinfostate.dart';
import 'package:groovroads/core/configs/constants/appurls.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        backgroundColor: context.isDarkMode ? const Color.fromARGB(255, 112, 94, 11) : const Color.fromARGB(255, 172, 148, 13),
        title: const Text('Your Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileInfo(context),
            SizedBox(height: 10),
            favoriteSongs()
          ],
        ),
      ),
    );
  }

  Widget profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color.fromARGB(255, 112, 94, 11) : const Color.fromARGB(255, 172, 148, 13),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60)
          )
        ),
      child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
        builder:(context, state)
          {
            if(state is ProfileInfoLoading){
              return const Center(child: CircularProgressIndicator());
            }
            if(state is ProfileInfoLoaded){
              String displayName = state.userEntity.fullName ?? state.userEntity.email!.split('@')[0];
              displayName = displayName[0].toUpperCase() + displayName.substring(1);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageURL ?? AppURLs.blankProfile),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(state.userEntity.fullName ?? displayName
                  , style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )),
                  const SizedBox(height: 10),
                  Text(state.userEntity.email!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300
                  )),
                ],
              );
            }
            if(state is ProfileInfoError){
              return Center(child: Text(state.message));
            }

            return Container();
          }
      ),
      ),
    );
  }

  Widget favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Favorite Songs', 
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400
              ),
            ),

            SizedBox(height: 25),
        
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if(state is FavoriteSongsLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                if(state is FavoriteSongsLoaded){
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 75, width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage('${AppURLs.coverFireStorage}${Uri.encodeComponent(state.favoriteSongs[index].artist)}%20-%20${Uri.encodeComponent(state.favoriteSongs[index].title)}.jpg?alt=media')
                                    )
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 220,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.favoriteSongs[index].title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        state.favoriteSongs[index].artist,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  state.favoriteSongs[index].duration.toString().replaceAll('.', ':'),
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 40, height: 40,
                                  child: FavButton(songEntity: state.favoriteSongs[index]))
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder:(context, index) => const SizedBox(height: 20,),
                      itemCount: state.favoriteSongs.length,
                    ),
                  );
                }
                if(state is FavoriteSongsError){
                  return Center(child: Text(state.message));
                }
                return Container();
              }
            )
          ],
        ),
      ),
    );
  }
}