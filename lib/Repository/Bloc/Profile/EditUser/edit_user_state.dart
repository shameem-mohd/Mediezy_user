part of 'edit_user_bloc.dart';

@immutable
sealed class EditUserState {}

final class EditUserInitial extends EditUserState {}

class EditUserDetailsLoading extends EditUserState{}
class EditUserDetailsLoaded extends EditUserState{}
class EditUserDetailsError extends EditUserState{}
