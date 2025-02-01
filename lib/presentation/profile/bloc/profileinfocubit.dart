import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/domain/usecases/auth/getuser.dart';
import 'package:groovroads/presentation/profile/bloc/profileinfostate.dart';
import 'package:groovroads/servicelocator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());
  Future<void> getUser() async {
    var user = await sl<GetUserUseCase>().call();

    user.fold(
      (l) => emit(ProfileInfoError(message: l.message)),
      (r) => emit(ProfileInfoLoaded(userEntity: r))
    );
  }
}