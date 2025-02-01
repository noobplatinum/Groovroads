import 'package:get_it/get_it.dart';
import 'package:groovroads/data/repository/auth/authrepoimpl.dart';
import 'package:groovroads/data/repository/song/songrepoimpl.dart';
import 'package:groovroads/data/sources/auth/auth_firebase.dart';
import 'package:groovroads/data/sources/songs/songfirebase.dart';
import 'package:groovroads/domain/repository/auth/auth.dart';
import 'package:groovroads/domain/usecases/auth/getuser.dart';
import 'package:groovroads/domain/usecases/auth/signin.dart';
import 'package:groovroads/domain/usecases/auth/signup.dart';
import 'package:groovroads/domain/usecases/song/addorremovefavorite.dart';
import 'package:groovroads/domain/usecases/song/getfavoritesongs.dart';
import 'package:groovroads/domain/usecases/song/getnewsongs.dart';
import 'package:groovroads/domain/usecases/song/getplaylist.dart';
import 'package:groovroads/domain/usecases/song/isfavorite.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SongRepositoryImpl>(SongRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<GetNewSongsUseCase>(GetNewSongsUseCase());

  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());

  sl.registerSingleton<AddOrRemoveFavoriteUseCase>(AddOrRemoveFavoriteUseCase());

  sl.registerSingleton<IsFavoriteUseCase>(IsFavoriteUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());

}