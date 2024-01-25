import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/AppointmentDoneScreen/appointment_done_screen.dart';

class TokenCardWidget extends StatefulWidget {
  const TokenCardWidget(
      {super.key,
      required this.tokenNumber,
      required this.time,
      required this.formatedTime,
      required this.date,
      required this.doctorId,
      required this.clinicId,
      required this.isBooked,
      required this.endingTime,
      required this.isTimeOut});

  final String tokenNumber;
  final String time;
  final String formatedTime;
  final DateTime date;
  final String doctorId;
  final String clinicId;
  final String isBooked;
  final String endingTime;
  final String isTimeOut;

  @override
  State<TokenCardWidget> createState() => _TokenCardWidgetState();
}

class _TokenCardWidgetState extends State<TokenCardWidget> {
  @override
  Widget build(BuildContext context) {
    Color containerColor;
    Color textColor;

    if (widget.isBooked == '1') {
      containerColor = Colors.grey.shade400;
    } else if (widget.isTimeOut == '1') {
      containerColor = Colors.grey.shade300;
    } else {
      containerColor = kCardColor;
    }

    if (widget.isBooked == '1') {
      textColor = Colors.grey.shade100;
    } else if (widget.isTimeOut == '1') {
      textColor = Colors.grey.shade600;
    } else {
      textColor = kTextColor;
    }

    return InkWell(
      onTap: () {
        widget.isBooked == '1' || widget.isTimeOut == '1'
            ? null
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentDoneScreen(
                    bookingDate: widget.date,
                    bookingTime: widget.time,
                    tokenNo: widget.tokenNumber,
                    doctorId: widget.doctorId,
                    clinicId: widget.clinicId,
                    bookingEndingTime: widget.endingTime,
                  ),
                ),
              );
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kMainColor, width: 1.5.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.tokenNumber,
              style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
            Text(
              widget.formatedTime,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
