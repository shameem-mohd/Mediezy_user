import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/Search/search_doctor_model.dart';
import 'package:mediezy_user/Repository/Bloc/SearchDoctor/search_doctor_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/Widgets/doctor_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  late SearchDoctorModel searchDoctorModel;
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
    BlocProvider.of<SearchDoctorBloc>(context)
        .add(FetchSeachedDoctor(searchQuery: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            final connectivityResult = snapshot.data;
            if (connectivityResult == ConnectivityResult.none) {
              return const InternetHandleScreen();
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (newValue) {
                            BlocProvider.of<SearchDoctorBloc>(context)
                                .add(FetchSeachedDoctor(searchQuery: newValue));
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              IconlyLight.search,
                              color: kMainColor,
                            ),
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: kSubTextColor),
                            hintText: "Search doctors",
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<SearchDoctorBloc, SearchDoctorState>(
                        builder: (context, state) {
                          if (state is SearchDoctorLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: kMainColor,
                              ),
                            );
                          }
                          if (state is SearchDoctorError) {
                            return Center(
                              child: Image(
                                image: const AssetImage(
                                    "assets/images/something went wrong-01.png"),
                                height: 200.h,
                                width: 200.w,
                              ),
                            );
                          }
                          if (state is SearchDoctorLoaded) {
                            searchDoctorModel =
                                BlocProvider.of<SearchDoctorBloc>(context)
                                    .searchDoctorModel;
                            return searchDoctorModel.docters == null
                                ? Center(
                                    child: Column(
                                      children: [
                                        const VerticalSpacingWidget(height: 80),
                                        Image(
                                          image: const AssetImage(
                                              "assets/icons/no doctor on searching.png"),
                                          height: 280.h,
                                          width: 280.w,
                                        ),
                                        Text(
                                          "There is no doctor\nas per your search",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        searchDoctorModel.docters!.length,
                                    itemBuilder: (context, index) {
                                      return DoctorCardWidget(
                                        doctorId: searchDoctorModel
                                            .docters![index].userId
                                            .toString(),
                                        firstName: searchDoctorModel
                                            .docters![index].firstname
                                            .toString(),
                                        lastName: searchDoctorModel
                                            .docters![index].secondname
                                            .toString(),
                                        imageUrl: searchDoctorModel
                                            .docters![index].docterImage
                                            .toString(),
                                        mainHospitalName: searchDoctorModel
                                            .docters![index].mainHospital
                                            .toString(),
                                        specialisation: searchDoctorModel
                                            .docters![index].specialization
                                            .toString(),
                                        location: searchDoctorModel
                                            .docters![index].location
                                            .toString(),
                                      );
                                    });
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
