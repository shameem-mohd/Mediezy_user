part of 'get_member_by_id_bloc.dart';

@immutable
sealed class GetMemberByIdState {}

final class GetMemberByIdInitial extends GetMemberByIdState {}


class GetMemberByIdLoading extends GetMemberByIdState{}
class GetMemberByIdLoaded extends GetMemberByIdState{}
class GetMemberByIdError extends GetMemberByIdState{}


