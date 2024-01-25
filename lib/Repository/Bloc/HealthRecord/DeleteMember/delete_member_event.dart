part of 'delete_member_bloc.dart';

@immutable
sealed class DeleteMemberEvent {}

class FetchDeleteMember extends DeleteMemberEvent {
  final String patientId;

  FetchDeleteMember({required this.patientId});
}
