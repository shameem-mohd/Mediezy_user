// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_user/Model/Clinics/clinic_model.dart';
import 'package:mediezy_user/Model/GetTokens/GetTokenModel.dart';
import 'package:mediezy_user/Repository/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/CommonWidgets/token_card_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({
    Key? key,
    required this.doctorId,
    required this.clinicList,
  }) : super(key: key);

  final String doctorId;
  final List<Clincs> clinicList;

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  late GetTokenModel getTokenModel;
  String selectedClinicId = "";
  bool isClicked = false;
  late StreamSubscription<ConnectivityResult> subscription;

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  @override
  void initState() {
    selectedClinicId = widget.clinicList.first.id.toString();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
    BlocProvider.of<GetTokenBloc>(context).add(
      FetchToken(
        date: formatDate(),
        doctorId: widget.doctorId,
        hospitalId: widget.clinicList.first.id.toString(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Date & Time"),
        centerTitle: true,
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          final connectivityResult = snapshot.data;
          if (connectivityResult == ConnectivityResult.none) {
            return const InternetHandleScreen();
          } else {
            return FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isClicked = !isClicked;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.clinicList
                                  .firstWhere(
                                    (clinic) =>
                                        clinic.id.toString() ==
                                        selectedClinicId,
                                    orElse: () =>
                                        Clincs(hospitalName: "Default Clinic"),
                                  )
                                  .hospitalName
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kSubTextColor),
                            ),
                            Icon(
                              isClicked
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down_rounded,
                              size: 30.sp,
                              color: kMainColor,
                            ),
                          ],
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      isClicked
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: widget.clinicList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                bool isSelected = selectedClinicId ==
                                    widget.clinicList[index].id.toString();
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedClinicId = widget
                                          .clinicList[index].id
                                          .toString();
                                      BlocProvider.of<GetTokenBloc>(context)
                                          .add(
                                        FetchToken(
                                          date: formatDate(),
                                          doctorId: widget.doctorId,
                                          hospitalId: selectedClinicId,
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 5.h),
                                    padding: const EdgeInsets.all(4),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isSelected
                                          ? kMainColor
                                          : const Color(0xFFEAF3F8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.clinicList[index]
                                                    .hospitalName
                                                    ?.toString() ??
                                                "Not Available",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: isSelected
                                                  ? Colors.white
                                                  : kTextColor,
                                            ),
                                          ),
                                          Text(
                                            widget.clinicList[index].address
                                                    ?.toString() ??
                                                "Not Available",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: isSelected
                                                  ? Colors.white
                                                  : kTextColor,
                                            ),
                                          ),
                                          Text(
                                            widget.clinicList[index].location
                                                    ?.toString() ??
                                                "Not Available",
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w400,
                                              color: isSelected
                                                  ? Colors.white
                                                  : kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(),
                      EasyDateTimeLine(
                        initialDate: selectedDate,
                        disabledDates: _getDisabledDates(),
                        onDateChange: (date) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          setState(() {
                            selectedDate = date;
                          });
                          BlocProvider.of<GetTokenBloc>(context).add(
                            FetchToken(
                              date: formattedDate,
                              doctorId: widget.doctorId,
                              hospitalId: selectedClinicId,
                            ),
                          );
                        },
                        activeColor: kMainColor,
                        dayProps: EasyDayProps(
                          height: 80.h,
                          width: 65.w,
                          activeDayNumStyle: TextStyle(
                            color: kCardColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                          activeDayStrStyle: TextStyle(
                            color: kCardColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                          activeMothStrStyle: TextStyle(
                            color: kCardColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                          todayHighlightStyle:
                              TodayHighlightStyle.withBackground,
                          todayHighlightColor: const Color(0xffE1ECC8),
                          borderColor: kMainColor,
                        ),
                      ),
                      BlocBuilder<GetTokenBloc, GetTokenState>(
                        builder: (context, state) {
                          if (state is GetTokenLoading) {
                            return SizedBox(
                              height: 200.h,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: kMainColor,
                                ),
                              ),
                            );
                          }
                          if (state is GetTokenError) {
                            return Center(
                              child: Image(
                                image: const AssetImage(
                                    "assets/images/something went wrong-01.png"),
                                height: 200.h,
                                width: 200.w,
                              ),
                            );
                          }
                          if (state is GetTokenLoaded) {
                            getTokenModel =
                                BlocProvider.of<GetTokenBloc>(context)
                                    .getTokenModel;
                            if (getTokenModel.tokenData == null) {
                              return Center(
                                child: Column(
                                  children: [
                                    const VerticalSpacingWidget(height: 20),
                                    Image(
                                      image: const AssetImage(
                                          "assets/icons/no token.png"),
                                      height: 250.h,
                                      width: 250.w,
                                    ),
                                    Text(
                                      "No Token available\non this date",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const VerticalSpacingWidget(height: 10),
                                if (getTokenModel
                                        .tokenData?.morningTokens?.isNotEmpty ==
                                    true)
                                  const Text(
                                    "Morning",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                const VerticalSpacingWidget(height: 10),
                                if (getTokenModel
                                        .tokenData?.morningTokens?.isNotEmpty ==
                                    true)
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: getTokenModel
                                        .tokenData!.morningTokens!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 5,
                                      mainAxisExtent: 78,
                                    ),
                                    itemBuilder: (context, index) {
                                      return TokenCardWidget(
                                        clinicId: selectedClinicId,
                                        date: selectedDate,
                                        isTimeOut: getTokenModel.tokenData!
                                            .morningTokens![index].isTimeout
                                            .toString(),
                                        endingTime: getTokenModel.tokenData!
                                            .morningTokens![index].tokens
                                            .toString(),
                                        tokenNumber: getTokenModel.tokenData!
                                            .morningTokens![index].number
                                            .toString(),
                                        time: getTokenModel.tokenData!
                                            .morningTokens![index].time
                                            .toString(),
                                        isBooked: getTokenModel.tokenData!
                                            .morningTokens![index].isBooked
                                            .toString(),
                                        doctorId: widget.doctorId,
                                        formatedTime: getTokenModel.tokenData!
                                            .morningTokens![index].formatedTime
                                            .toString(),
                                      );
                                    },
                                  ),
                                const VerticalSpacingWidget(height: 10),
                                if (getTokenModel
                                        .tokenData?.eveningTokens?.isNotEmpty ==
                                    true)
                                  const Text(
                                    "Evening",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                const VerticalSpacingWidget(height: 10),
                                if (getTokenModel
                                        .tokenData?.eveningTokens?.isNotEmpty ==
                                    true)
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    shrinkWrap: true,
                                    itemCount: getTokenModel
                                        .tokenData!.eveningTokens!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 5,
                                      mainAxisExtent: 70,
                                    ),
                                    itemBuilder: (context, index) {
                                      return TokenCardWidget(
                                        clinicId: selectedClinicId,
                                        date: selectedDate,
                                        isTimeOut: getTokenModel.tokenData!
                                            .eveningTokens![index].isTimeout
                                            .toString(),
                                        endingTime: getTokenModel.tokenData!
                                            .eveningTokens![index].tokens
                                            .toString(),
                                        tokenNumber: getTokenModel.tokenData!
                                            .eveningTokens![index].number
                                            .toString(),
                                        time: getTokenModel.tokenData!
                                            .eveningTokens![index].time
                                            .toString(),
                                        isBooked: getTokenModel.tokenData!
                                            .eveningTokens![index].isBooked
                                            .toString(),
                                        doctorId: widget.doctorId,
                                        formatedTime: getTokenModel.tokenData!
                                            .eveningTokens![index].formatedTime
                                            .toString(),
                                      );
                                    },
                                  ),
                                const VerticalSpacingWidget(height: 10)
                              ],
                            );
                          }
                          return Container(
                            color: Colors.yellow,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  List<DateTime> _getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];
    for (int month = 1; month <= currentDate.month; month++) {
      int lastDay = month < currentDate.month ? 31 : currentDate.day;

      for (int day = 1; day < lastDay; day++) {
        disabledDates.add(DateTime(currentDate.year, month, day));
      }
    }
    return disabledDates;
  }

  String formatDate() {
    return DateFormat('yyyy-MM-dd').format(selectedDate);
  }
}
