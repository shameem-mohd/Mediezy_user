part of 'add_member_bloc.dart';

@immutable
sealed class AddMemberState {}

final class AddMemberInitial extends AddMemberState {}

class AddMemberLoadingState extends AddMemberState{}
class AddMemberLoadedState extends AddMemberState{}
class AddMemberErrorState extends AddMemberState{}
