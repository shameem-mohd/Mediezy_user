part of 'edit_user_bloc.dart';

@immutable
sealed class EditUserEvent {}

class FetchEditUser extends EditUserEvent {
  final String firstName;
  final String secondName;
  final String email;
  final String mobileNo;
  final String location;
  final String gender;

  FetchEditUser(
      {required this.firstName,
      required this.secondName,
      required this.email,
      required this.mobileNo,
      required this.location,
      required this.gender});
}
