import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/common/bloc/favbutton/favbuttonstate.dart';
import 'package:groovroads/domain/usecases/song/addorremovefavorite.dart';
import 'package:groovroads/servicelocator.dart';

class FavButtonCubit extends Cubit<FavButtonState> {
  FavButtonCubit() : super(FavButtonInitial());

  void favButtonUpdated(String songId) async {
    var result = await sl<AddOrRemoveFavoriteUseCase>().call(
      params: songId
    );

    result.fold(
      (l){},
      (isFavorited) => emit(FavButtonUpdated(
        isFavorited: isFavorited ?? false
      ))
    );
  }
}