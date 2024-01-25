part of 'login_and_signup_bloc.dart';

@immutable
abstract class LoginAndSignupEvent {}

//* login
class LoginEvent extends LoginAndSignupEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends LoginAndSignupEvent {
  final String email;
  final String password;
  final String firstname;
  final String secondname;
  final String mobileNo;
  final String gender;
  final String age;
  final String location;
  final File? userImage;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.firstname,
    required this.secondname,
    required this.mobileNo,
    required this.gender,
    required this.age,
    required this.location,
    this.userImage,
  });
}
