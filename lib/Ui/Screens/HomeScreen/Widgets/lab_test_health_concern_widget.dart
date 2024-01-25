import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTestHealthConcernWidget extends StatelessWidget {
  const LabTestHealthConcernWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          image: AssetImage(imageUrl),
          height: 100.h,
          width: 110.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
