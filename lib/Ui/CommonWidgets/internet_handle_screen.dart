import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class InternetHandleScreen extends StatelessWidget {
  const InternetHandleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      beginOffset: const Offset(0, 0.3),
      endOffset: const Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadedScaleAnimation(
                scaleDuration: const Duration(milliseconds: 400),
                fadeDuration: const Duration(milliseconds: 400),
                child: Image.asset("assets/icons/no internet.png")),
            const VerticalSpacingWidget(height: 10),
            const Text(
              "Sorry! Something seems wrong",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VerticalSpacingWidget(height: 5),
            Text(
              "Please check your internet connection",
              style: TextStyle(
                fontSize: 15.sp,
                color: kSubTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
