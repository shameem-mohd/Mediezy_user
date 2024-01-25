import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/DoctorDetailsScreen/doctor_details_screen.dart';

class DoctorNearYouWidget extends StatelessWidget {
  const DoctorNearYouWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.location,
    required this.doctorId,
  });

  final String doctorId;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String location;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 8.w, 0),
        child: Container(
          height: 155.h,
          width: 130.w,
          decoration: BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    height: 110.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                ),
              ),
              const VerticalSpacingWidget(height: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  "Dr $firstName $lastName",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: kTextColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const VerticalSpacingWidget(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: SizedBox(
                  width: 120.w,
                  child: Text(
                    'Loc: $location',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: kSubTextColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
