import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetSymptomAndDoctor/get_health_symptoms_model.dart';
import 'package:mediezy_user/Repository/Bloc/GetHealthSymptomsAndDoctor/GetHealthSymptoms/get_health_symptoms_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/HomeScreen/DoctorsByHealthSymptomsScreen/doctor_by_health_symptoms_screen.dart';

class HealthSymptomsListingScreen extends StatefulWidget {
  const HealthSymptomsListingScreen({super.key});

  @override
  State<HealthSymptomsListingScreen> createState() =>
      _HealthSymptomsListingScreenState();
}

class _HealthSymptomsListingScreenState
    extends State<HealthSymptomsListingScreen> {
  late GetHealthSymptomsModel getHealthSymptomsModel;
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
    BlocProvider.of<GetHealthSymptomsBloc>(context)
        .add(FetchAllHealthSymptoms());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors By Symptoms"),
        centerTitle: true,
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          final connectivityResult = snapshot.data;
          if (connectivityResult == ConnectivityResult.none) {
            return const InternetHandleScreen();
          } else {
            return BlocBuilder<GetHealthSymptomsBloc, GetHealthSymptomsState>(
              builder: (context, state) {
                if (state is GetHealthSymptomsLoading) {
                  return SizedBox(
                    height: 60.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    ),
                  );
                }
                if (state is GetHealthSymptomsError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                if (state is GetHealthSymptomsLoaded) {
                  getHealthSymptomsModel =
                      BlocProvider.of<GetHealthSymptomsBloc>(context)
                          .getHealthSymptomsModel;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getHealthSymptomsModel.categories!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.70),
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorByHealthSymptomsScreen(
                                    healthSymptomsName: getHealthSymptomsModel
                                        .categories![index].categoryName
                                        .toString(),
                                    healthSymptomsId: getHealthSymptomsModel
                                        .categories![index].id
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(
                                  getHealthSymptomsModel
                                      .categories![index].image
                                      .toString(),
                                ),
                                width: 120.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        }),
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
