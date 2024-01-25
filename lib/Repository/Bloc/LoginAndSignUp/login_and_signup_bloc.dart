// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_user/Model/auth/login_model.dart';
import 'package:mediezy_user/Model/auth/sign_up_model.dart';
import 'package:mediezy_user/Repository/Api/LoginAndSignUp/login_and_sign_up_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_and_signup_event.dart';
part 'login_and_signup_state.dart';

class LoginAndSignupBloc
    extends Bloc<LoginAndSignupEvent, LoginAndSignupState> {
  LoginAndSignupBloc() : super(LoginAndSignupInitial()) {
    late LoginModel loginModel;
    late SignUpModel signUpModel;
    LoginAndSignUpApi loginAndSignUpApi = LoginAndSignUpApi();
    //* login bloc
    on<LoginEvent>((event, emit) async {
      final preference = await SharedPreferences.getInstance();
      emit(LoginLoading());
      print("<<<<<<<Loading>>>>>>>");
      try {
        String? userId;
        loginModel = await loginAndSignUpApi.login(
            email: event.email, password: event.password);
        preference.setString('token', loginModel.token.toString());
        preference.setString(
            'firstName', loginModel.user!.firstname.toString());
        preference.setString(
            'lastName', loginModel.user!.secondname.toString());
        preference.setString('userId', loginModel.user!.id.toString());
        userId = preference.getString('userId').toString();
        print("<<<<<<userrr  $userId>>>>>>>>");
        preference.setString(
            'phoneNumber', loginModel.user!.mobileNo.toString());
        String? token = await preference.getString('token');
        print("Tokken >>>>>>>>>>>>>>>>>>$token");
        emit(LoginLoaded());
      } catch (error) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>" + error.toString());
        emit(LoginError());
      }
    });

    //* signup bloc
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      print("<<<<<<<Loading>>>>>>>");
      try {
        // Check if userImage is not null before using it
        signUpModel = await loginAndSignUpApi.signUp(
          email: event.email,
          password: event.password,
          firstName: event.firstname,
          secondName: event.secondname,
          mobileNumber: event.mobileNo,
          age: event.age,
          gender: event.gender,
          location: event.location,
          event.userImage,
        );

        emit(SignUpLoaded());
        print("loaded");
      } catch (error) {
        print("Signup Error>>>>>>>>>>>>>>>>>>>>>>" + error.toString());
        emit(SignUpError());
      }
    });
  }
}
