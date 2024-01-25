part of 'add_favourites_bloc.dart';

@immutable
sealed class AddFavouritesEvent {}

class AddFavourites extends AddFavouritesEvent {
  final String doctorId;
  AddFavourites({required this.doctorId});
}

