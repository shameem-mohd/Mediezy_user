part of 'get_favourites_bloc.dart';

@immutable
sealed class GetFavouritesEvent {}

class FetchAllFavourites extends GetFavouritesEvent{}
