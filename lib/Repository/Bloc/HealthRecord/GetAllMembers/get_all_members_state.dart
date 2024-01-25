part of 'get_all_members_bloc.dart';

@immutable
sealed class GetAllMembersState {}

final class GetAllMembersInitial extends GetAllMembersState {}

class GetAllMembersLoading extends GetAllMembersState{}
class GetAllMembersLoaded extends GetAllMembersState{}
class GetAllMembersError extends GetAllMembersState{}
