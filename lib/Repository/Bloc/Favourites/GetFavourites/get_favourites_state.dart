part of 'get_favourites_bloc.dart';

@immutable
sealed class GetFavouritesState {}

final class GetFavouritesInitial extends GetFavouritesState {}

class GetAllFavouritesLoading extends GetFavouritesState{}
class GetAllFavouritesLoaded extends GetFavouritesState{}
class GetAllFavouritesError extends GetFavouritesState{}

