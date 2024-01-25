part of 'get_user_bloc.dart';

@immutable
sealed class GetUserState {}

final class GetUserInitial extends GetUserState {}

class GetUserDetailsLoading extends GetUserState{}
class GetUserDetailsLoaded extends GetUserState{}
class GetUserDetailsError extends GetUserState{}

