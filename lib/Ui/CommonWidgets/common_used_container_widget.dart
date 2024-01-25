import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class CommomUsedContainerWidget extends StatefulWidget {
  const CommomUsedContainerWidget({super.key, required this.text});

  final String text;

  @override
  State<CommomUsedContainerWidget> createState() =>
      _CommomUsedContainerWidgetState();
}

class _CommomUsedContainerWidgetState extends State<CommomUsedContainerWidget> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isClicked ? Colors.grey : kCardColor,
          border: Border.all(color: kMainColor, width: 1),
        ),
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(6.0),
        child: Text(
          widget.text,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              color: isClicked ? Colors.white : kTextColor),
        ),
      ),
    );
  }
}
