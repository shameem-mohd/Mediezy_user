import 'dart:async';
import 'dart:io';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/EditUser/edit_user_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/UploadUserImage/upload_user_image_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({
    super.key,
    required this.firstName,
    required this.secondname,
    required this.email,
    required this.phNo,
    required this.location,
    required this.gender,
    required this.imageUrl,
  });
  final String firstName;
  final String secondname;
  final String email;
  final String phNo;
  final String location;
  final String gender;
  final String imageUrl;
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String genderValue = "";
  String selectedGender = '';
  File? imageFromGallery;
  late StreamSubscription<ConnectivityResult> subscription;

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
    genderValue = widget.gender == "1" ? "Male" : "Female";
    selectedGender = widget.gender == "1" ? "1" : "2";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Edit"),
        centerTitle: true,
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            final connectivityResult = snapshot.data;
            if (connectivityResult == ConnectivityResult.none) {
              return const InternetHandleScreen();
            } else {
              return BlocListener<EditUserBloc, EditUserState>(
                listener: (context, state) {
                  if (state is EditUserDetailsLoaded) {
                    GeneralServices.instance
                        .showToastMessage("Profile Edit Successfully");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const BottomNavigationControlWidget(),
                      ),
                    );
                  }
                },
                child: FadedSlideAnimation(
                  beginOffset: const Offset(0, 0.3),
                  endOffset: const Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          const VerticalSpacingWidget(height: 10),
                          Stack(
                            children: [
                              Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: FadedScaleAnimation(
                                  scaleDuration:
                                      const Duration(milliseconds: 400),
                                  fadeDuration:
                                      const Duration(milliseconds: 400),
                                  child: ClipOval(
                                    child: imageFromGallery != null
                                        ? Image.file(
                                            imageFromGallery!,
                                            height: 80.h,
                                            width: 80.w,
                                            fit: BoxFit.fill,
                                          )
                                        : (widget.imageUrl ==
                                                "https://mediezy.com/UserImages"
                                            ? Image.asset(
                                                "assets/icons/profile pic.png",
                                                height: 80.h,
                                                width: 80.w,
                                                color: kMainColor,
                                              )
                                            : Image.network(
                                                widget.imageUrl,
                                                height: 80.h,
                                                width: 80.w,
                                                fit: BoxFit.fill,
                                              )),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -10.h,
                                right: -12.w,
                                child: IconButton(
                                  onPressed: () {
                                    pickImageFromGallery();
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    size: 26.sp,
                                    weight: 5,
                                    color: kMainColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! first name
                          TextFormField(
                            cursorColor: kMainColor,
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                IconlyLight.profile,
                                color: kMainColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: widget.firstName,
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          // const VerticalSpacingWidget(height: 20),
                          //! last name
                          // TextFormField(
                          //   cursorColor: kMainColor,
                          //   controller: secondNameController,
                          //   keyboardType: TextInputType.name,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: InputDecoration(
                          //     prefixIcon: Icon(
                          //       IconlyBroken.profile,
                          //       color: kMainColor,
                          //     ),
                          //     hintStyle:
                          //         TextStyle(fontSize: 15.sp, color: kSubTextColor),
                          //     hintText: widget.secondname,
                          //     filled: true,
                          //     fillColor: kCardColor,
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(4),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //   ),
                          // ),
                          const VerticalSpacingWidget(height: 20),
                          //! phone number
                          TextFormField(
                            cursorColor: kMainColor,
                            controller: mobileNoController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone_iphone,
                                color: kMainColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: widget.phNo,
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 20),
                          TextFormField(
                            cursorColor: kMainColor,
                            controller: locationController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: kMainColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: widget.location,
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 20),
                          //! gender
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Radio<String>(
                                  activeColor: kMainColor,
                                  value: "Male",
                                  groupValue: genderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      genderValue = value!;
                                      selectedGender = 1.toString();
                                    });
                                  }),
                              Text(
                                "Male",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              Radio<String>(
                                  activeColor: kMainColor,
                                  value: "Female",
                                  groupValue: genderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      genderValue = value!;
                                      selectedGender = 2.toString();
                                    });
                                  }),
                              Text(
                                "Female",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              Radio<String>(
                                  activeColor: kMainColor,
                                  value: "Other",
                                  groupValue: genderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      genderValue = value!;
                                      selectedGender = 3.toString();
                                    });
                                  }),
                              Text(
                                "Other",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ],
                          ),
                          const VerticalSpacingWidget(height: 30),
                          CommonButtonWidget(
                              title: "Update",
                              onTapFunction: () {
                                BlocProvider.of<EditUserBloc>(context).add(
                                  FetchEditUser(
                                      firstName: firstNameController.text,
                                      secondName: secondNameController.text,
                                      mobileNo: mobileNoController.text,
                                      email: emailController.text,
                                      location: locationController.text,
                                      gender: selectedGender),
                                );
                                BlocProvider.of<UploadUserImageBloc>(context)
                                    .add(
                                  FetchUploadUserImage(
                                      userImage: imageFromGallery!),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  //* pick image from gallery
  Future pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFromGallery = File(pickedFile.path);
      } else {
        GeneralServices.instance.showToastMessage('Please select image');
      }
    });
  }
}
