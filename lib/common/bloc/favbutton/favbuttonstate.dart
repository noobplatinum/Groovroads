abstract class FavButtonState  {
}

class FavButtonInitial extends FavButtonState {
}

class FavButtonUpdated extends FavButtonState {
  final bool isFavorited;

  FavButtonUpdated({required this.isFavorited});
} 

class FavButtonError extends FavButtonState {
  final String message;

  FavButtonError({required this.message});
}