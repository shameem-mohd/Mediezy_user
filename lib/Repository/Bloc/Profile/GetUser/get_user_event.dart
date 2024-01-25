part of 'get_user_bloc.dart';

@immutable
sealed class GetUserEvent {}

class FetchUserDetails extends GetUserEvent{}
