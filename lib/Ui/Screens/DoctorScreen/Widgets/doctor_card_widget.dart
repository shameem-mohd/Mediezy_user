import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/DoctorDetailsScreen/doctor_details_screen.dart';

class DoctorCardWidget extends StatelessWidget {
  const DoctorCardWidget({
    super.key,
    required this.doctorId,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.mainHospitalName,
    required this.specialisation, required this.location,
  });

  final String doctorId;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String mainHospitalName;
  final String specialisation;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 8.0.h, bottom: 18.0.h, left: 8.w, right: 10.w),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailsScreen(
                    doctorId: doctorId,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                FadedScaleAnimation(
                  scaleDuration: const Duration(milliseconds: 400),
                  fadeDuration: const Duration(milliseconds: 400),
                  child: Image.network(
                    imageUrl,
                    height: 80.h,
                    width: 80.w,
                  ),
                ),
                const HorizontalSpacingWidget(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpacingWidget(height: 12),
                    Text(
                      "Dr.$firstName $lastName",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const VerticalSpacingWidget(height: 5),
                    Row(
                      children: [
                        Text(
                          specialisation,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: kSubTextColor),
                        ),
                        const HorizontalSpacingWidget(width: 5),
                        Text(
                          "at",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff979797),
                          ),
                        ),
                        const HorizontalSpacingWidget(width: 5),
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            mainHospitalName,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: kSubTextColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const VerticalSpacingWidget(height: 15),
                    Row(
                      children: [
                        Text(
                          "Location: ",
                          style:
                              TextStyle(fontSize: 12.sp, color: kSubTextColor),
                        ),
                        Text(
                          location,
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                        const HorizontalSpacingWidget(width: 8),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 4.h,
          thickness: 6.sp,
          color: kCardColor,
        ),
      ],
    );
  }
}
