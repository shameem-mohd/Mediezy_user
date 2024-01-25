part of 'edit_member_bloc.dart';

@immutable
sealed class EditMemberEvent {}

class FetchEditMember extends EditMemberEvent {
  final String patientId;
  final String age;
  final String fullName;
  final String gender;

  FetchEditMember(
      {required this.patientId,
      required this.age,
      required this.fullName,
      required this.gender});
}
