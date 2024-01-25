part of 'login_and_signup_bloc.dart';

@immutable
sealed class LoginAndSignupState {}

final class LoginAndSignupInitial extends LoginAndSignupState {}

class LoginLoading extends LoginAndSignupState{}
class LoginLoaded extends LoginAndSignupState{}
class LoginError extends LoginAndSignupState{}


class SignUpLoading extends LoginAndSignupState{}
class SignUpLoaded extends LoginAndSignupState{}
class SignUpError extends LoginAndSignupState{}




