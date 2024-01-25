import 'dart:async';

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetSymptomAndDoctor/get_doctor_as_per_health_symptoms_model.dart';
import 'package:mediezy_user/Repository/Bloc/GetHealthSymptomsAndDoctor/GetDoctorAsPerSymptoms/get_doctor_as_per_symptoms_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/Widgets/doctor_card_widget.dart';

class DoctorByHealthSymptomsScreen extends StatefulWidget {
  const DoctorByHealthSymptomsScreen(
      {super.key,
      required this.healthSymptomsName,
      required this.healthSymptomsId});

  final String healthSymptomsName;
  final String healthSymptomsId;

  @override
  State<DoctorByHealthSymptomsScreen> createState() =>
      _DoctorByHealthSymptomsScreenState();
}

class _DoctorByHealthSymptomsScreenState
    extends State<DoctorByHealthSymptomsScreen> {
  late GetDoctorAsPerHealthSymptomsModel getDoctorAsPerHealthSymptomsModel;
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
    BlocProvider.of<GetDoctorAsPerSymptomsBloc>(context).add(
      FetchDoctorAsPerHealthSymptoms(id: widget.healthSymptomsId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      beginOffset: const Offset(0, 0.3),
      endOffset: const Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.healthSymptomsName),
          centerTitle: true,
        ),
        body: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              final connectivityResult = snapshot.data;
              if (connectivityResult == ConnectivityResult.none) {
                return const InternetHandleScreen();
              } else {
                return BlocBuilder<GetDoctorAsPerSymptomsBloc,
                    GetDoctorAsPerSymptomsState>(
                  builder: (context, state) {
                    if (state is GetDoctorsAsperHealthSymptomsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    }
                    if (state is GetDoctorsAsperHealthSymptomsError) {
                      return Center(
                        child: Image(
                          image: const AssetImage(
                              "assets/images/something went wrong-01.png"),
                          height: 200.h,
                          width: 200.w,
                        ),
                      );
                    }
                    if (state is GetDoctorsAsperHealthSymptomsLoaded) {
                      getDoctorAsPerHealthSymptomsModel =
                          BlocProvider.of<GetDoctorAsPerSymptomsBloc>(context)
                              .getDoctorAsPerHealthSymptomsModel;
                      return FadedSlideAnimation(
                        beginOffset: const Offset(0, 0.3),
                        endOffset: const Offset(0, 0),
                        slideCurve: Curves.linearToEaseOut,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              children: [
                                const VerticalSpacingWidget(height: 15),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return DoctorCardWidget(
                                        doctorId:
                                            getDoctorAsPerHealthSymptomsModel
                                                .data![index].userid
                                                .toString(),
                                        firstName:
                                            getDoctorAsPerHealthSymptomsModel
                                                .data![index].firstname
                                                .toString(),
                                        imageUrl:
                                            getDoctorAsPerHealthSymptomsModel
                                                .data![index].docterImage
                                                .toString(),
                                        lastName:
                                            getDoctorAsPerHealthSymptomsModel
                                                .data![index].secondname
                                                .toString(),
                                        location:
                                            getDoctorAsPerHealthSymptomsModel
                                                .data![index].location
                                                .toString(),
                                        mainHospitalName:
                                            getDoctorAsPerHealthSymptomsModel
                                                .data![index].mainHospital
                                                .toString(),
                                        specialisation:
                                            getDoctorAsPerHealthSymptomsModel
                                                .data![index].specialization
                                                .toString(),
                                      );
                                    },
                                    itemCount: getDoctorAsPerHealthSymptomsModel
                                        .data!.length)
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                );
              }
            }),
      ),
    );
  }
}
