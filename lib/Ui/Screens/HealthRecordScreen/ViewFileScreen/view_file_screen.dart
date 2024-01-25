import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class ViewFileScreen extends StatefulWidget {
  const ViewFileScreen({Key? key, required this.viewFile}) : super(key: key);

  final String viewFile;

  @override
  State<ViewFileScreen> createState() => _ViewFileScreenState();
}

class _ViewFileScreenState extends State<ViewFileScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          if (_isLoading)
            SizedBox(
              height: 600.h,
              child: Center(
                child: CircularProgressIndicator(
                  color: kMainColor,
                ),
              ),
            )
          else
            SizedBox(
              height: 580.h,
              width: double.infinity,
              child: Image(
                image: NetworkImage(widget.viewFile),
              ),
            ),
        ],
      ),
    );
  }
}
