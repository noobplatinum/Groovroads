import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/domain/usecases/song/getfavoritesongs.dart';
import 'package:groovroads/presentation/profile/bloc/favoritesongsstate.dart';
import 'package:groovroads/servicelocator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit(): super(FavoriteSongsLoading());

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUseCase>().call();
    result.fold(
      (l) => emit(FavoriteSongsError(message: l.message)),
      (r) => emit(FavoriteSongsLoaded(favoriteSongs: r))
    );
  }
}