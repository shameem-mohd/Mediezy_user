// ignore_for_file: deprecated_member_use

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Repository/Bloc/LoginAndSignUp/login_and_signup_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Data/app_datas.dart';
import 'package:mediezy_user/Ui/Screens/AuthenticationScreens/ForegetPasswordScreen/forget_password_screen.dart';
import 'package:mediezy_user/Ui/Screens/AuthenticationScreens/SignUpScreen/sign_up_screen.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusController = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginAndSignupBloc, LoginAndSignupState>(
      listener: (context, state) {
        if (state is LoginLoaded) {
          GeneralServices.instance.showToastMessage("Login Successfully");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigationControlWidget()),
              (route) => false);
        }
        if (state is LoginError) {
          GeneralServices.instance
              .showToastMessage("Please Enter Correct details");
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: Scaffold(
          body: FadedSlideAnimation(
            beginOffset: const Offset(0, 0.3),
            endOffset: const Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: 400.h,
                    child: Swiper(
                      autoplay: true,
                      itemCount: loginScreenImages.length,
                      itemBuilder: ((context, index) {
                        return Image.asset(
                          loginScreenImages[index],
                          fit: BoxFit.cover,
                        );
                      }),
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                            color: Colors.grey,
                            activeColor: Colors.grey[200],
                            size: 8.sp,
                            activeSize: 8.sp),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const VerticalSpacingWidget(height: 400),
                          //! email
                          TextFormField(
                            cursorColor: kMainColor,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !value.contains("@gmail.com")) {
                                return "Please enter the valid email address";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: kMainColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: "Enter your email",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! password
                          TextFormField(
                            cursorColor: kMainColor,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            focusNode: passwordFocusController,
                            textInputAction: TextInputAction.done,
                            obscureText: hidePassword,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return "Please enter correct password";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(IconlyLight.password, color: kMainColor),
                              suffixIcon: hidePassword
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      icon: Icon(
                                        IconlyLight.hide,
                                        color: kMainColor,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      icon: Icon(
                                        IconlyLight.show,
                                        color: kMainColor,
                                      ),
                                    ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: "Enter your password",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! forgetpassword
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forget password",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: kMainColor),
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! login
                          CommonButtonWidget(
                              title: "Login",
                              onTapFunction: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginAndSignupBloc>(context)
                                      .add(
                                    LoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text),
                                  );
                                }
                              }),
                          const VerticalSpacingWidget(height: 10),
                          //! sign up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const HorizontalSpacingWidget(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: kMainColor),
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpacingWidget(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocusController.dispose();
    super.dispose();
  }
}
