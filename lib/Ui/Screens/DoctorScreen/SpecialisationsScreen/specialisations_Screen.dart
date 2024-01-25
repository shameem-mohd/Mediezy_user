// ignore_for_file: file_names

import 'dart:async';

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetSpecialisations/get_specialisations_model.dart';
import 'package:mediezy_user/Repository/Bloc/GetSpecialisations/GetAllSpecialisations/get_all_specialisations_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/DoctorsBySpecialisationScreen/doctors_by_specialisation_screen.dart';

class SpecialisationsScreen extends StatefulWidget {
  const SpecialisationsScreen({super.key});

  @override
  State<SpecialisationsScreen> createState() => _SpecialisationsScreenState();
}

class _SpecialisationsScreenState extends State<SpecialisationsScreen> {
  late GetSpecialisationsModel getSpecialisationModel;
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
    BlocProvider.of<GetAllSpecialisationsBloc>(context)
        .add(FetchAllSpecialisations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Specialisations"),
        centerTitle: true,
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          final connectivityResult = snapshot.data;
          if (connectivityResult == ConnectivityResult.none) {
            return const InternetHandleScreen();
          } else {
            return BlocBuilder<GetAllSpecialisationsBloc,
                GetAllSpecialisationsState>(
              builder: (context, state) {
                if (state is GetAllSpecialisationsError) {
                  return Center(
                    child: Image(
                      image: const AssetImage(
                          "assets/images/something went wrong-01.png"),
                      height: 200.h,
                      width: 200.w,
                    ),
                  );
                }
                if (state is GetAllSpecialisationsLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kMainColor,
                    ),
                  );
                }
                if (state is GetAllSpecialisationsLoaded) {
                  getSpecialisationModel =
                      BlocProvider.of<GetAllSpecialisationsBloc>(context)
                          .getSpecialisationsModel;
                  return FadedSlideAnimation(
                    beginOffset: const Offset(0, 0.3),
                    endOffset: const Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const VerticalSpacingWidget(height: 15),
                              //! specialisations card
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: getSpecialisationModel
                                    .specializations!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio: 0.90),
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorsBySpecialisationScreen(
                                            specialisationName:
                                                getSpecialisationModel
                                                    .specializations![index]
                                                    .specialization
                                                    .toString(),
                                            specialisationId:
                                                getSpecialisationModel
                                                    .specializations![index].id
                                                    .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: NetworkImage(
                                          getSpecialisationModel
                                              .specializations![index]
                                              .specializeimage
                                              .toString(),
                                        ),
                                        width: 120.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              const VerticalSpacingWidget(height: 10)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}
