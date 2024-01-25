part of 'add_member_bloc.dart';

@immutable
sealed class AddMemberEvent {}

class FetchAddMember extends AddMemberEvent {
  final String fullName;
  final String age;
  final String relation;
  final String gender;
  final String mobileNumber;
  final String regularMedicine;
  final String allergyId;
  final String allergyName;
  final String surgeyName;
  final String treatmentTaken;
  final String illness;
  final String medicineTaken;

  FetchAddMember({
    required this.fullName,
    required this.age,
    required this.relation,
    required this.gender,
    required this.mobileNumber,
    required this.regularMedicine,
    required this.allergyId,
    required this.allergyName,
    required this.surgeyName,
    required this.treatmentTaken,
    required this.illness,
    required this.medicineTaken,
  });
}
