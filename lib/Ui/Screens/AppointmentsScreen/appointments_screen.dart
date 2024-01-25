// ignore_for_file: file_names, deprecated_member_use

import 'dart:async';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetAppointments/get_completed_appointments_model.dart';
import 'package:mediezy_user/Model/GetAppointments/get_upcoming_appointments_model.dart';
import 'package:mediezy_user/Repository/Bloc/GetAppointment/GetCompletedAppointments/get_completed_appointments_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetAppointment/GetUpcomingAppointment/get_upcoming_appointment_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/AppointmentsScreen/Widgets/appointment_card_widget.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late GetUpComingAppointmentsModel getUpComingAppointmentsModel;
  late GetCompletedAppointmentsModel getCompletedAppointmentsModel;
  late Timer pollingTimer;
  late StreamSubscription<ConnectivityResult> subscription;

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
    BlocProvider.of<GetUpcomingAppointmentBloc>(context)
        .add(FetchUpComingAppointments());
    BlocProvider.of<GetCompletedAppointmentsBloc>(context)
        .add(FetchCompletedAppointments());
    super.initState();
    startPolling();
  }

  void startPolling() async {
    pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      BlocProvider.of<GetUpcomingAppointmentBloc>(context)
          .add(FetchUpComingAppointments());
    });
  }

  void stopPolling() {
    pollingTimer.cancel();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigationControlWidget(),
            ),
          );
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My Bookings"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: kMainColor,
              indicatorColor: kMainColor,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Up Coming",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Completed",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          body: StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                final connectivityResult = snapshot.data;
                if (connectivityResult == ConnectivityResult.none) {
                  return const InternetHandleScreen();
                } else {
                  return TabBarView(children: [
                    //!up coming
                    BlocBuilder<GetUpcomingAppointmentBloc,
                        GetUpcomingAppointmentState>(
                      builder: (context, state) {
                        if (state is GetUpComingAppointmentLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: kMainColor,
                            ),
                          );
                        }
                        if (state is GetUpComingAppointmentError) {
                          return Center(
                            child: Image(
                              image: const AssetImage(
                                  "assets/images/something went wrong-01.png"),
                              height: 200.h,
                              width: 200.w,
                            ),
                          );
                        }
                        if (state is GetUpComingAppointmentLoaded) {
                          if (state.isLoaded) {
                            getUpComingAppointmentsModel =
                                BlocProvider.of<GetUpcomingAppointmentBloc>(
                                        context)
                                    .getUpComingAppointmentsModel;
                            return getUpComingAppointmentsModel.appointments ==
                                    null
                                ? Center(
                                    child: Column(
                                      children: [
                                        const VerticalSpacingWidget(height: 80),
                                        Image(
                                          image: const AssetImage(
                                              "assets/icons/no appointment.png"),
                                          height: 250.h,
                                          width: 250.w,
                                        ),
                                        Text(
                                          "No Appointments available",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: getUpComingAppointmentsModel
                                        .appointments!
                                        .appointmentsDetails!
                                        .length,
                                    itemBuilder: (context, index) {
                                      return AppointmentCardWidget(
                                        clinicList: getUpComingAppointmentsModel
                                            .appointments!
                                            .appointmentsDetails![index]
                                            .clincs!
                                            .toList(),
                                        doctorId: getUpComingAppointmentsModel
                                            .appointments!
                                            .appointmentsDetails![index]
                                            .doctorId
                                            .toString(),
                                        leaveMessage:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .leaveMessage
                                                .toString(),
                                        docterImage:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .docterImage
                                                .toString(),
                                        docterFirstname:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .firstname
                                                .toString(),
                                        docterSecondName:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .secondname
                                                .toString(),
                                        appointmentFor:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .mainSymptoms!
                                                .first
                                                .symtoms
                                                .toString(),
                                        tokenNumber:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .tokenNumber
                                                .toString(),
                                        appointmentDate:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .date
                                                .toString(),
                                        appointmentTime:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .startingtime
                                                .toString(),
                                        patientName:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .patientName
                                                .toString(),
                                        bookinTime: getUpComingAppointmentsModel
                                            .appointments!
                                            .appointmentsDetails![index]
                                            .tokenBookingTime
                                            .toString(),
                                        bookingDate:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .tokenBookingDate
                                                .toString(),
                                        consultationStartingTime:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .consultationStartsfrom
                                                .toString(),
                                        earlyTime: getUpComingAppointmentsModel
                                            .appointments!
                                            .appointmentsDetails![index]
                                            .doctorEarlyFor
                                            .toString(),
                                        estimatedArrivalTime:
                                            getUpComingAppointmentsModel
                                                        .appointments!
                                                        .appointmentsDetails![
                                                            index]
                                                        .estimateTime ==
                                                    null
                                                ? getUpComingAppointmentsModel
                                                    .appointments!
                                                    .appointmentsDetails![index]
                                                    .startingtime
                                                    .toString()
                                                : getUpComingAppointmentsModel
                                                    .appointments!
                                                    .appointmentsDetails![index]
                                                    .estimateTime
                                                    .toString(),
                                        lateTime: getUpComingAppointmentsModel
                                            .appointments!
                                            .appointmentsDetails![index]
                                            .doctorLateFor
                                            .toString(),
                                        liveToken: getUpComingAppointmentsModel
                                                .appointments
                                                ?.appointmentsDetails![index]
                                                .currentOngoingToken ??
                                            '0'.toString(),
                                        bookedClinicName:
                                            getUpComingAppointmentsModel
                                                .appointments!
                                                .appointmentsDetails![index]
                                                .mainHospital
                                                .toString(),
                                      );
                                    });
                          }
                        }
                        return Container();
                      },
                    ),
                    //! completed
                    BlocBuilder<GetCompletedAppointmentsBloc,
                        GetCompletedAppointmentsState>(
                      builder: (context, state) {
                        if (state is GetCompletedAppointmentLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: kMainColor,
                            ),
                          );
                        }
                        if (state is GetCompletedAppointmentError) {
                          return Center(
                            child: Image(
                              image: const AssetImage(
                                  "assets/images/something went wrong-01.png"),
                              height: 200.h,
                              width: 200.w,
                            ),
                          );
                        }
                        if (state is GetCompletedAppointmentLoaded) {
                          getCompletedAppointmentsModel =
                              BlocProvider.of<GetCompletedAppointmentsBloc>(
                                      context)
                                  .getCompletedAppointmentsModel;
                          return getCompletedAppointmentsModel
                                  .appointments!.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      const VerticalSpacingWidget(height: 80),
                                      Image(
                                        image: const AssetImage(
                                            "assets/icons/no appointment.png"),
                                        height: 250.h,
                                        width: 250.w,
                                      ),
                                      Text(
                                        "No Appointments available",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: getCompletedAppointmentsModel
                                      .appointments!.length,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8.0.h,
                                                  bottom: 18.0.h,
                                                  left: 8.w,
                                                  right: 10.w),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    FadedScaleAnimation(
                                                      scaleDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  400),
                                                      fadeDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  400),
                                                      child: Image.network(
                                                        getCompletedAppointmentsModel
                                                            .appointments![
                                                                index]
                                                            .docterImage
                                                            .toString(),
                                                        height: 80.h,
                                                        width: 80.w,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const VerticalSpacingWidget(
                                                              height: 10),
                                                          Text(
                                                            "Dr.${getCompletedAppointmentsModel.appointments![index].firstname.toString()} ${getCompletedAppointmentsModel.appointments![index].secondname.toString()}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            getCompletedAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .mainHospital
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    kSubTextColor),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Appointment for: ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kSubTextColor),
                                                              ),
                                                              Text(
                                                                getCompletedAppointmentsModel
                                                                    .appointments![
                                                                        index]
                                                                    .mainSymptoms!
                                                                    .first
                                                                    .symtoms
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kSubTextColor),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    getCompletedAppointmentsModel
                                                                        .appointments![
                                                                            index]
                                                                        .date
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color:
                                                                          kTextColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    " | ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color:
                                                                          kTextColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    getCompletedAppointmentsModel
                                                                        .appointments![
                                                                            index]
                                                                        .startingtime
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color:
                                                                          kTextColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const HorizontalSpacingWidget(
                                                                  width: 40),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "For : ",
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            kSubTextColor),
                                                                  ),
                                                                  Text(
                                                                    getCompletedAppointmentsModel
                                                                        .appointments![
                                                                            index]
                                                                        .patientName
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color:
                                                                          kTextColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              height: 4.h,
                                              thickness: 6.sp,
                                              color: kCardColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                        }
                        return Container();
                      },
                    ),
                  ]);
                }
              }),
        ),
      ),
    );
  }
}
