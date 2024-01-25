import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class DoctorSpecalityListTileWidget extends StatelessWidget {
  const DoctorSpecalityListTileWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios, color: kMainColor, size: 17),
        )
      ],
    );
  }
}
