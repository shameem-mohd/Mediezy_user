// ignore_for_file: unnecessary_null_comparison, avoid_print, deprecated_member_use

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetAllMembers/get_all_members_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/DeleteMember/delete_member_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllMembers/get_all_members_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Data/app_datas.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/AddDocumentScreen/add_document_screen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/AddPatientScreen/AddPatientScreen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/AllRecordsScreen/all_records_screen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/EditPatientScreen/edit_patient_screen.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';

class HealthRecordScreen extends StatefulWidget {
  const HealthRecordScreen({super.key});

  @override
  State<HealthRecordScreen> createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
  late GetAllMembersModel getAllMembersModel;
  bool isClicked = false;
  int selectedPatientIndex = 0;
  String patientId = "";

  @override
  void initState() {
    BlocProvider.of<GetAllMembersBloc>(context).add(FetchAllMembers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      beginOffset: const Offset(0, 0.3),
      endOffset: const Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
      child: WillPopScope(
        onWillPop: () {
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
            title: const Text("Health Records"),
            centerTitle: true,
          ),
          body: BlocListener<DeleteMemberBloc, DeleteMemberState>(
            listener: (context, state) {
              if(state is DeleteMemberLoaded){
                BlocProvider.of<GetAllMembersBloc>(context).add(FetchAllMembers());
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      color: kCardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<GetAllMembersBloc, GetAllMembersState>(
                            builder: (context, state) {
                              if (state is GetAllMembersLoading) {
                                return SizedBox(
                                  height: 60.h,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: kMainColor,
                                    ),
                                  ),
                                );
                              }
                              if (state is GetAllMembersError) {
                                return const Center(
                                  child: Text("Something Went Wrong"),
                                );
                              }
                              if (state is GetAllMembersLoaded) {
                                getAllMembersModel =
                                    BlocProvider.of<GetAllMembersBloc>(context)
                                        .getAllMembersModel;
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              getAllMembersModel
                                                  .patientsData!.first.firstname
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const HorizontalSpacingWidget(
                                                width: 10),
                                            Text(
                                              "MAA000${getAllMembersModel.patientsData!.first.id.toString()}",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isClicked = !isClicked;
                                            });
                                          },
                                          icon: Icon(
                                            isClicked
                                                ? Icons.keyboard_arrow_up
                                                : Icons
                                                    .keyboard_arrow_down_rounded,
                                            size: 30.sp,
                                            color: kMainColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 60.h,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: getAllMembersModel
                                                .patientsData!.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedPatientIndex =
                                                        index;
                                                    // isClicked = !isClicked;
                                                    patientId =
                                                        getAllMembersModel
                                                            .patientsData![
                                                                index]
                                                            .id
                                                            .toString();
                                                  });
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 5.w),
                                                        height: 40.h,
                                                        width: 40.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              selectedPatientIndex ==
                                                                      index
                                                                  ? kMainColor
                                                                  : kCardColor,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  kMainColor),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "${getAllMembersModel.patientsData![index].firstname![0].toUpperCase()}${getAllMembersModel.patientsData![index].firstname![1].toUpperCase()}",
                                                            style: TextStyle(
                                                              color: selectedPatientIndex ==
                                                                      index
                                                                  ? kCardColor
                                                                  : kTextColor,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      getAllMembersModel
                                                          .patientsData![index]
                                                          .firstname
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kTextColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              try {
                                                if (getAllMembersModel
                                                        .patientsData!.length ==
                                                    6) {
                                                  GeneralServices.instance
                                                      .showDialogue(
                                                    context,
                                                    "Unable to add patient. The maximum limit for patients has been reached",
                                                  );
                                                } else {
                                                  bool addedData =
                                                      await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AddPatientScreen(),
                                                    ),
                                                  );
                                                  if (addedData != null &&
                                                      addedData) {
                                                    await fetchAllMembers();
                                                  }
                                                }
                                              } catch (error, stackTrace) {
                                                print(
                                                    'Error in InkWell onTap: $error');
                                                print(
                                                    'Stack Trace: $stackTrace');
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                FadedScaleAnimation(
                                                  scaleDuration: const Duration(
                                                      milliseconds: 400),
                                                  fadeDuration: const Duration(
                                                      milliseconds: 400),
                                                  child: Container(
                                                    height: 40.h,
                                                    width: 40.w,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: kMainColor),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 25.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Add",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: kTextColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalSpacingWidget(height: 5),
                                    isClicked
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: getAllMembersModel
                                                .patientsData!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5.h),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  height: 50.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        selectedPatientIndex ==
                                                                index
                                                            ? const Color(
                                                                0xFFEAF3F8)
                                                            : const Color(
                                                                0xFFF8FCFF),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                getAllMembersModel
                                                                    .patientsData![
                                                                        index]
                                                                    .firstname
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kTextColor),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Gender: ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kSubTextColor),
                                                              ),
                                                              Text(
                                                                getAllMembersModel
                                                                            .patientsData![index]
                                                                            .gender ==
                                                                        "1"
                                                                    ? "Male"
                                                                    : "Female",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kTextColor),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    " | ",
                                                                    style: TextStyle(
                                                                        fontSize: 11
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color:
                                                                            kTextColor),
                                                                  ),
                                                                  Text(
                                                                    "Age: ",
                                                                    style: TextStyle(
                                                                        fontSize: 11
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            kSubTextColor),
                                                                  ),
                                                                  Text(
                                                                    getAllMembersModel
                                                                        .patientsData![
                                                                            index]
                                                                        .age
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: 11
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color:
                                                                            kTextColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                " | ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        kTextColor),
                                                              ),
                                                              Text(
                                                                "MED ID: ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kSubTextColor),
                                                              ),
                                                              Text(
                                                                getAllMembersModel
                                                                    .patientsData![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        kTextColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          index == 0
                                                              ? Container()
                                                              : IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    bool addedData = await Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(builder:
                                                                            (context) {
                                                                      return EditPatientScreen(
                                                                        patientId: getAllMembersModel
                                                                            .patientsData![index]
                                                                            .id
                                                                            .toString(),
                                                                        gender: getAllMembersModel
                                                                            .patientsData![index]
                                                                            .gender
                                                                            .toString(),
                                                                      );
                                                                    }));
                                                                    if (addedData !=
                                                                            null &&
                                                                        addedData) {
                                                                      await fetchAllMembers();
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .edit_outlined,
                                                                    color:
                                                                        kMainColor,
                                                                    size: 20.sp,
                                                                  ),
                                                                ),
                                                          index == 0
                                                              ? Container()
                                                              : IconButton(
                                                                  onPressed:
                                                                      () {
                                                                        GeneralServices
                                                                            .instance
                                                                            .appCloseDialogue(
                                                                      context,
                                                                      "Are you sure to delete?",
                                                                      () {
                                                                        BlocProvider.of<DeleteMemberBloc>(context)
                                                                            .add(
                                                                          FetchDeleteMember(
                                                                            patientId:
                                                                            getAllMembersModel.patientsData![index].id.toString(),
                                                                          ),
                                                                        );
                                                                        fetchAllMembers();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    );

                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete_outlined,
                                                                    color:
                                                                        kMainColor,
                                                                    size: 20.sp,
                                                                  ),
                                                                ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : Container()
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpacingWidget(height: 10),
                    SizedBox(
                      height: 140.h,
                      child: Swiper(
                        autoplay: true,
                        itemCount: healthRecordBanners.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 6.w, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                healthRecordBanners[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        }),
                        pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.grey[200],
                              activeColor: Colors.red[400],
                              size: 8.sp,
                              activeSize: 8.sp),
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllRecordsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 80.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kCardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FadedScaleAnimation(
                              scaleDuration: const Duration(milliseconds: 400),
                              fadeDuration: const Duration(milliseconds: 400),
                              child: Image(
                                image:
                                    const AssetImage("assets/icons/folder.png"),
                                height: 35.h,
                                width: 55.w,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "All Health Records",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: kTextColor),
                                ),
                                Text(
                                  "Prescriptions, Lab report, Scanning report",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: kSubTextColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 10),
                    Text(
                      "Upload Your Health Documents",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: kSubTextColor),
                    ),
                    const VerticalSpacingWidget(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //! add prescription
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddDocumentScreen(
                                  appBarTitle: "Upload Prescription",
                                  type: 2,
                                  stringType: "Prescription",
                                ),
                              ),
                            );
                          },
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const Image(
                                image: AssetImage(
                                    "assets/icons/add prescription.jpg"),
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        ),
                        //!lab report
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddDocumentScreen(
                                  appBarTitle: "Upload Lab Report",
                                  type: 1,
                                  stringType: "Lab report",
                                ),
                              ),
                            );
                          },
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const Image(
                                image:
                                    AssetImage("assets/icons/lab report.jpg"),
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        ),
                        //!scan report
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddDocumentScreen(
                                  appBarTitle: "Upload Scanning Report",
                                  type: 1,
                                  stringType: "Scanning report",
                                ),
                              ),
                            );
                          },
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const Image(
                                image: AssetImage(
                                    "assets/icons/scanning report.jpg"),
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const VerticalSpacingWidget(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchAllMembers() async {
    try {
      BlocProvider.of<GetAllMembersBloc>(context).add(FetchAllMembers());
    } catch (error, stackTrace) {
      print('Error fetching all members: $error');
      print('Stack Trace: $stackTrace');
    }
  }
}