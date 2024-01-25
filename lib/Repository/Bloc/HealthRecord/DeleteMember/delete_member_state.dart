part of 'delete_member_bloc.dart';

@immutable
sealed class DeleteMemberState {}

final class DeleteMemberInitial extends DeleteMemberState {}


class DeleteMemberLoading extends DeleteMemberState{}
class DeleteMemberLoaded extends DeleteMemberState{}
class DeleteMemberError extends DeleteMemberState{}

