import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget(
      {super.key,
      required this.title,
      required this.viewAllFunction});

  final String title;
  final Function viewAllFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: kSubTextColor),
        ),
       InkWell(
                onTap: () {
                  viewAllFunction();
                },
                child: Text(
                  "View all",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: kMainColor),
                ),
              )
      ],
    );
  }
}
