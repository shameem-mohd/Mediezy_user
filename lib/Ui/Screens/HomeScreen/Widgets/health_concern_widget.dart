import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Screens/HomeScreen/DoctorsByHealthCategoryScreen/doctors_by_health_caregory_screen.dart';

class HealthConcernWidget extends StatelessWidget {
  const HealthConcernWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.healthCategoryId});

  final String imageUrl;
  final String title;
  final String healthCategoryId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DoctorsByHealthCatrgoryScreen(
                healthCategoryId: healthCategoryId, healthCategoryName: title),
          ),
        );
      },
      child: FadedScaleAnimation(
        scaleDuration: const Duration(milliseconds: 400),
        fadeDuration: const Duration(milliseconds: 400),
        child: Column(
          children: [
            CircleAvatar(
              radius: 35.sp,
              backgroundColor: Colors.blue[100],
              backgroundImage: NetworkImage(
                imageUrl,
              ),
            ),
            const VerticalSpacingWidget(height: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
