part of 'edit_member_bloc.dart';

@immutable
sealed class EditMemberState {}

final class EditMemberInitial extends EditMemberState {}

class EditMemberLoaded extends EditMemberState{}
class EditMemberLoading extends EditMemberState{}
class EditMemberError extends EditMemberState{}

