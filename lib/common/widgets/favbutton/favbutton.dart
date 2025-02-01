import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/common/bloc/favbutton/favbuttoncubit.dart';
import 'package:groovroads/common/bloc/favbutton/favbuttonstate.dart';
import 'package:groovroads/domain/entities/song/song.dart';

class FavButton extends StatelessWidget {
  final SongEntity songEntity;
  const FavButton({required this.songEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavButtonCubit(),
      child: BlocBuilder<FavButtonCubit, FavButtonState>(
        builder: (context, state) {
          if (state is FavButtonInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavButtonCubit>().favButtonUpdated(
                  songEntity.songId,
                );
              },
              icon: Icon(
                songEntity.isFavorited ? Icons.favorite : Icons.favorite_outline_outlined,
                size: 30,
                color: const Color.fromARGB(255, 102, 102, 102),
              ),
            );
          }

          if (state is FavButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavButtonCubit>().favButtonUpdated(
                  songEntity.songId,
                );
              },
              icon: Icon(
                state.isFavorited ? Icons.favorite : Icons.favorite_outline_outlined,
                size: 30,
                color: const Color.fromARGB(255, 102, 102, 102),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}