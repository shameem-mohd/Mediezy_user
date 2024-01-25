part of 'get_family_members_bloc.dart';

@immutable
sealed class GetFamilyMembersState {}

final class GetFamilyMembersInitial extends GetFamilyMembersState {}


class GetFamilyMembersLoading extends GetFamilyMembersState{}

class GetFamilyMembersLoaded extends GetFamilyMembersState{}

class GetFamilyMembersError extends GetFamilyMembersState{}
