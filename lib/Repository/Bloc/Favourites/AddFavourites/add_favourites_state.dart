part of 'add_favourites_bloc.dart';

@immutable
sealed class AddFavouritesState {}

final class AddFavouritesInitial extends AddFavouritesState {}

class AddFavouritesLoading extends AddFavouritesState{}
class AddFavouritesLoaded extends AddFavouritesState{}
class AddFavouritesError extends AddFavouritesState{}


