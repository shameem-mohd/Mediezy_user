part of 'get_family_members_bloc.dart';

@immutable
sealed class GetFamilyMembersEvent {}


class FetchFamilyMember extends GetFamilyMembersEvent{}
