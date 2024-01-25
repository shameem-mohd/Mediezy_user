import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetAllMembers/get_all_members_model.dart';
import 'package:mediezy_user/Model/GetAllUploadedDocuments/get_all_uploaded_documet_model.dart';
import 'package:mediezy_user/Model/GetUploadedPrescriptions/get_uploaded_prescription_model.dart';
import 'package:mediezy_user/Model/GetUploadedScanningAndLabReport/get_uploaded_scanning_and_lab_report_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/DeleteDocument/delete_document_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllLabAndScanningReports/get_all_scanning_and_lab_reports_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllMembers/get_all_members_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllPrescriptions/get_all_prescriptions_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllUploadedDocuments/get_all_uploaded_documents_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/EditLabAndScanScreen/edit_lab_and_scan_screen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/EditPrescriptionScreen/edit_prescription_screen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/PrescriptionViewScreen/prescription_view_screen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/ViewFileScreen/view_file_screen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/ViewTimeLineScreen/view_time_line_screen.dart';

class AllRecordsScreen extends StatefulWidget {
  const AllRecordsScreen({Key? key}) : super(key: key);

  @override
  State<AllRecordsScreen> createState() => _AllRecordsScreenState();
}

class _AllRecordsScreenState extends State<AllRecordsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late GetAllMembersModel getAllMembersModel;
  late GetAllUploadedDocumentModel getAllUploadedDocumentModel;
  late GetUploadedPrescriptionModel getUploadedPrescriptionModel;
  late GetUploadedScanningAndLabModel getUploadedScanningAndLabModel;

  late ValueNotifier<int> dropValueMemberNotifier;
  int dropValueMember = 0;
  late String selectedMemberId = "";
  late List<PatientsData> patientId;
  late List<PatientsData> patientNames = [];
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
    tabController = TabController(length: 4, vsync: this);
    BlocProvider.of<GetAllMembersBloc>(context).add(FetchAllMembers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Record"),
        centerTitle: true,
      ),
      body: BlocListener<DeleteDocumentBloc, DeleteDocumentState>(
        listener: (context, state) {
          if (state is DeleteDocumentLoaded) {
            BlocProvider.of<GetAllPrescriptionsBloc>(context)
                .add(
              FetchUploadedPrescriptions(
                  patientId: selectedMemberId),
            );
            BlocProvider.of<GetAllScanningAndLabReportsBloc>(
                context)
                .add(
              FetchUploadedScanningAndLabReports(
                  patientId: selectedMemberId),
            );
          }
        },
        child: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              final connectivityResult = snapshot.data;
              if (connectivityResult == ConnectivityResult.none) {
                return const InternetHandleScreen();
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Patient",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: kSubTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const VerticalSpacingWidget(height: 5),
                      BlocBuilder<GetAllMembersBloc, GetAllMembersState>(
                        builder: (context, state) {
                          if (state is GetAllMembersLoaded) {
                            getAllMembersModel =
                                BlocProvider.of<GetAllMembersBloc>(context)
                                    .getAllMembersModel;
                            if (patientNames.isEmpty) {
                              patientNames
                                  .addAll(getAllMembersModel.patientsData!);
                              dropValueMemberNotifier =
                                  ValueNotifier<int>(patientNames.first.id!);
                              dropValueMember = patientNames.first.id!;
                              selectedMemberId =
                                  patientNames.first.id.toString();
                            }
                            BlocProvider.of<GetAllUploadedDocumentsBloc>(
                                    context)
                                .add(
                              FetchAllUploadedDocuments(
                                  patientId: selectedMemberId),
                            );
                            BlocProvider.of<GetAllPrescriptionsBloc>(context)
                                .add(
                              FetchUploadedPrescriptions(
                                  patientId: selectedMemberId),
                            );
                            BlocProvider.of<GetAllScanningAndLabReportsBloc>(
                                    context)
                                .add(
                              FetchUploadedScanningAndLabReports(
                                  patientId: selectedMemberId),
                            );
                            return Container(
                              height: 40.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: kCardColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0xFF9C9C9C))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Center(
                                  child: ValueListenableBuilder(
                                    valueListenable: dropValueMemberNotifier,
                                    builder: (BuildContext context,
                                        int dropValue, _) {
                                      return DropdownButtonFormField(
                                        iconEnabledColor: kMainColor,
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        value: dropValue,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: kTextColor),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        onChanged: (int? value) {
                                          dropValue = value!;
                                          dropValueMemberNotifier.value = value;
                                          dropValueMember = value;
                                          selectedMemberId = value.toString();
                                          BlocProvider.of<
                                                      GetAllUploadedDocumentsBloc>(
                                                  context)
                                              .add(
                                            FetchAllUploadedDocuments(
                                                patientId: selectedMemberId),
                                          );
                                          BlocProvider.of<
                                                      GetAllPrescriptionsBloc>(
                                                  context)
                                              .add(
                                            FetchUploadedPrescriptions(
                                                patientId: selectedMemberId),
                                          );
                                          BlocProvider.of<
                                                      GetAllScanningAndLabReportsBloc>(
                                                  context)
                                              .add(
                                            FetchUploadedScanningAndLabReports(
                                                patientId: selectedMemberId),
                                          );
                                        },
                                        items: patientNames
                                            .map<DropdownMenuItem<int>>(
                                                (value) {
                                          return DropdownMenuItem<int>(
                                            value: value.id!,
                                            child: Text(value.firstname!),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      const VerticalSpacingWidget(height: 10),
                      Container(
                        color: Colors.transparent,
                        height: 30.h,
                        child: TabBar(
                          controller: tabController,
                          indicator: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: kMainColor,
                                width: 4.sp,
                              ),
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: kMainColor,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: const [
                            Center(child: Text("All")),
                            Center(child: Text("Prescription")),
                            Center(child: Text("Lab Report")),
                            Center(child: Text("Scan Report")),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            //! all uploaded documents
                            BlocBuilder<GetAllUploadedDocumentsBloc,
                                GetAllUploadedDocumentsState>(
                              builder: (context, state) {
                                if (state is GetAllUploadedDocumentsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kMainColor,
                                    ),
                                  );
                                }
                                if (state is GetAllUploadedDocumentsError) {
                                  return Center(
                                    child: Image(
                                      image: const AssetImage(
                                          "assets/images/something went wrong-01.png"),
                                      height: 200.h,
                                      width: 200.w,
                                    ),
                                  );
                                }
                                if (state is GetAllUploadedDocumentsLoaded) {
                                  getAllUploadedDocumentModel = BlocProvider.of<
                                          GetAllUploadedDocumentsBloc>(context)
                                      .getAllUploadedDocumentModel;
                                  return getAllUploadedDocumentModel
                                              .documentData ==
                                          null
                                      ? Image.asset("assets/icons/no data.png")
                                      : ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemCount: getAllUploadedDocumentModel
                                              .documentData!.length,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const VerticalSpacingWidget(
                                                      height: 3),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5.h, 0, 2.h),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  child: Container(
                                                    height: 100.h,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: kCardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (ctx) =>
                                                                    ViewFileScreen(
                                                                  viewFile: getAllUploadedDocumentModel
                                                                      .documentData![
                                                                          index]
                                                                      .documentPath
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height: 90.h,
                                                              width: 80.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    kScaffoldColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child:
                                                                  const Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image(
                                                                    height: 30,
                                                                    width: 30,
                                                                    image:
                                                                        AssetImage(
                                                                      'assets/icons/file view.png',
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      "View File")
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const HorizontalSpacingWidget(
                                                            width: 10),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          100.w,
                                                                      top: 5.h),
                                                              child: Text(
                                                                "Updated - ${getAllUploadedDocumentModel.documentData![index].hoursAgo.toString()} hours ago",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kSubTextColor),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: 200.w,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Patient :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getAllUploadedDocumentModel
                                                                              .documentData![index]
                                                                              .patient
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Record Date :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getAllUploadedDocumentModel
                                                                              .documentData![index]
                                                                              .date
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                        );
                                }
                                return Container();
                              },
                            ),
                            //! prescriptions
                            BlocBuilder<GetAllPrescriptionsBloc,
                                GetAllPrescriptionsState>(
                              builder: (context, state) {
                                if (state is GetAllPrescriptionsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kMainColor,
                                    ),
                                  );
                                }
                                if (state is GetAllPrescriptionsError) {
                                  return Center(
                                    child: Image(
                                      image: const AssetImage(
                                          "assets/images/something went wrong-01.png"),
                                      height: 200.h,
                                      width: 200.w,
                                    ),
                                  );
                                }
                                if (state is GetAllPrescriptionsLoaded) {
                                  getUploadedPrescriptionModel =
                                      BlocProvider.of<GetAllPrescriptionsBloc>(
                                              context)
                                          .getUploadedPrescriptionModel;
                                  return getUploadedPrescriptionModel
                                              .documentData ==
                                          null
                                      ? Image.asset("assets/icons/no data.png")
                                      : ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              getUploadedPrescriptionModel
                                                  .documentData!.length,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const VerticalSpacingWidget(
                                                      height: 3),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5.h, 0, 2.h),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  child: Container(
                                                    height: 120.h,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: kCardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (ctx) =>
                                                                    ViewFileScreen(
                                                                  viewFile: getUploadedPrescriptionModel
                                                                      .documentData![
                                                                          index]
                                                                      .documentPath
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height: 90.h,
                                                              width: 80.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    kScaffoldColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image(
                                                                    height:
                                                                        40.h,
                                                                    width: 40.w,
                                                                    image:
                                                                        const AssetImage(
                                                                      'assets/icons/prescription (3).png',
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                      "View File")
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const HorizontalSpacingWidget(
                                                            width: 10),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Updated - ${getUploadedPrescriptionModel.documentData![index].hoursAgo} hours ago",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          kSubTextColor),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                const HorizontalSpacingWidget(
                                                                    width: 60),
                                                                PopupMenuButton(
                                                                  iconSize:
                                                                      20.sp,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color:
                                                                        kMainColor,
                                                                  ),
                                                                  itemBuilder:
                                                                      (context) =>
                                                                          <PopupMenuEntry<
                                                                              dynamic>>[
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .push(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                EditPrescriptionScreen(
                                                                              documentId: getUploadedPrescriptionModel.documentData![index].id.toString(),
                                                                              patientId: getAllUploadedDocumentModel.documentData![index].patientId.toString(),
                                                                              // type:
                                                                              //     getAllUploadedDocumentModel.documentData![index].type.toString(),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Edit",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight: FontWeight.w700),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        BlocProvider.of<DeleteDocumentBloc>(context)
                                                                            .add(
                                                                          FetchDeletedDocument(
                                                                              documentId: getUploadedPrescriptionModel.documentData![index].id.toString(),
                                                                              type: "2"),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Delete",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight: FontWeight.w700),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: 200.w,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Patient :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedPrescriptionModel
                                                                              .documentData![index]
                                                                              .patient
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Record Date :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedPrescriptionModel
                                                                              .documentData![index]
                                                                              .patientPrescription!
                                                                              .first
                                                                              .date
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Prescribed by :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedPrescriptionModel.documentData![index].patientPrescription?.first.doctorName?.toString() ??
                                                                              "No Prescription",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (ctx) =>
                                                                            PrescriptionViewScreen(
                                                                      name: getUploadedPrescriptionModel
                                                                          .documentData![
                                                                              index]
                                                                          .patient
                                                                          .toString(),
                                                                      patientId: getUploadedPrescriptionModel
                                                                          .documentData![
                                                                              index]
                                                                          .patientId
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 180
                                                                            .w,
                                                                        bottom:
                                                                            5.h),
                                                                child: Text(
                                                                  "View",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .blue),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                        );
                                }
                                return Container();
                              },
                            ),
                            //! lab report
                            BlocBuilder<GetAllScanningAndLabReportsBloc,
                                GetAllScanningAndLabReportsState>(
                              builder: (context, state) {
                                if (state
                                    is GetAllScanningAndLabReportsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kMainColor,
                                    ),
                                  );
                                }
                                if (state is GetAllScanningAndLabReportsError) {
                                  return Center(
                                    child: Image(
                                      image: const AssetImage(
                                          "assets/images/something went wrong-01.png"),
                                      height: 200.h,
                                      width: 200.w,
                                    ),
                                  );
                                }
                                if (state
                                    is GetAllScanningAndLabReportsLoaded) {
                                  getUploadedScanningAndLabModel = BlocProvider
                                          .of<GetAllScanningAndLabReportsBloc>(
                                              context)
                                      .getUploadedScanningAndLabModel;
                                  return getUploadedScanningAndLabModel
                                              .documentData ==
                                          null
                                      ? Image.asset("assets/icons/no data.png")
                                      : ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              getUploadedScanningAndLabModel
                                                  .documentData!.length,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const VerticalSpacingWidget(
                                                      height: 3),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5.h, 0, 2.h),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  child: Container(
                                                    height: 120.h,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: kCardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (ctx) =>
                                                                    ViewFileScreen(
                                                                  viewFile: getUploadedScanningAndLabModel
                                                                      .documentData![
                                                                          index]
                                                                      .documentPath
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height: 90.h,
                                                              width: 80.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    kScaffoldColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child:
                                                                  const Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image(
                                                                    height: 40,
                                                                    width: 40,
                                                                    image:
                                                                        AssetImage(
                                                                      'assets/icons/Lab report (2).png',
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      "View File")
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const HorizontalSpacingWidget(
                                                            width: 10),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Updated - ${getUploadedScanningAndLabModel.documentData![index].hoursAgo} hours ago",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          kSubTextColor),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                const HorizontalSpacingWidget(
                                                                    width: 60),
                                                                PopupMenuButton(
                                                                  iconSize:
                                                                      20.sp,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color:
                                                                        kMainColor,
                                                                  ),
                                                                  itemBuilder:
                                                                      (context) =>
                                                                          <PopupMenuEntry<
                                                                              dynamic>>[
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .push(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                EditLabAndScanScreen(
                                                                              documentId: getUploadedScanningAndLabModel.documentData![index].id.toString(),
                                                                              patientId: getUploadedScanningAndLabModel.documentData![index].patientId.toString(),
                                                                              type: getUploadedScanningAndLabModel.documentData![index].type.toString(),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Edit",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight: FontWeight.w700),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        BlocProvider.of<DeleteDocumentBloc>(context)
                                                                            .add(
                                                                          FetchDeletedDocument(
                                                                              documentId: getUploadedScanningAndLabModel.documentData![index].id.toString(),
                                                                              type: "1"),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Delete",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight: FontWeight.w700),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: 200.w,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Patient :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedScanningAndLabModel
                                                                              .documentData![index]
                                                                              .patient!
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Record Date :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedScanningAndLabModel
                                                                              .documentData![index]
                                                                              .labReport!
                                                                              .first
                                                                              .date
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Lab Name :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedScanningAndLabModel
                                                                              .documentData![index]
                                                                              .labReport!
                                                                              .first
                                                                              .labName
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (ctx) =>
                                                                            ViewInTimeLineScreen(
                                                                      name: getUploadedScanningAndLabModel
                                                                          .documentData![
                                                                              index]
                                                                          .patient!
                                                                          .toString(),
                                                                      patientId: getUploadedScanningAndLabModel
                                                                          .documentData![
                                                                              index]
                                                                          .patientId
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 70
                                                                            .w,
                                                                        bottom:
                                                                            5.h),
                                                                child: Text(
                                                                  "View in timeline",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .blue),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                        );
                                }
                                return Container();
                              },
                            ),
                            //! scanning report
                            BlocBuilder<GetAllScanningAndLabReportsBloc,
                                GetAllScanningAndLabReportsState>(
                              builder: (context, state) {
                                if (state
                                    is GetAllScanningAndLabReportsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kMainColor,
                                    ),
                                  );
                                }
                                if (state is GetAllScanningAndLabReportsError) {
                                  return Center(
                                    child: Image(
                                      image: const AssetImage(
                                          "assets/images/something went wrong-01.png"),
                                      height: 200.h,
                                      width: 200.w,
                                    ),
                                  );
                                }
                                if (state
                                    is GetAllScanningAndLabReportsLoaded) {
                                  getUploadedScanningAndLabModel = BlocProvider
                                          .of<GetAllScanningAndLabReportsBloc>(
                                              context)
                                      .getUploadedScanningAndLabModel;
                                  return getUploadedScanningAndLabModel
                                              .documentData ==
                                          null
                                      ? Image.asset("assets/icons/no data.png")
                                      : ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              getUploadedScanningAndLabModel
                                                  .documentData!.length,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const VerticalSpacingWidget(
                                                      height: 3),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5.h, 0, 2.h),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  child: Container(
                                                    height: 120.h,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: kCardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (ctx) =>
                                                                    ViewFileScreen(
                                                                  viewFile: getUploadedScanningAndLabModel
                                                                      .documentData![
                                                                          index]
                                                                      .documentPath
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height: 90.h,
                                                              width: 80.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    kScaffoldColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child:
                                                                  const Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image(
                                                                    height: 40,
                                                                    width: 40,
                                                                    image:
                                                                        AssetImage(
                                                                      'assets/icons/file view.png',
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      "View File")
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const HorizontalSpacingWidget(
                                                            width: 10),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Updated - ${getUploadedScanningAndLabModel.documentData![index].hoursAgo} hours ago",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          kSubTextColor),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                const HorizontalSpacingWidget(
                                                                    width: 60),
                                                                PopupMenuButton(
                                                                  iconSize:
                                                                      20.sp,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color:
                                                                        kMainColor,
                                                                  ),
                                                                  itemBuilder:
                                                                      (context) =>
                                                                          <PopupMenuEntry<
                                                                              dynamic>>[
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .push(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                EditLabAndScanScreen(
                                                                              documentId: getUploadedScanningAndLabModel.documentData![index].id.toString(),
                                                                              patientId: getUploadedScanningAndLabModel.documentData![index].patientId.toString(),
                                                                              type: getUploadedScanningAndLabModel.documentData![index].type.toString(),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Edit",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight: FontWeight.w700),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        BlocProvider.of<DeleteDocumentBloc>(context)
                                                                            .add(
                                                                          FetchDeletedDocument(
                                                                              documentId: getUploadedScanningAndLabModel.documentData![index].id.toString(),
                                                                              type: "1"),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Delete",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight: FontWeight.w700),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: 200.w,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Patient :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedScanningAndLabModel
                                                                              .documentData![index]
                                                                              .patient!
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Record Date :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedScanningAndLabModel
                                                                              .documentData![index]
                                                                              .labReport!
                                                                              .first
                                                                              .date
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Lab Name :",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: kSubTextColor),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          getUploadedScanningAndLabModel
                                                                              .documentData![index]
                                                                              .labReport!
                                                                              .first
                                                                              .labName
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                        );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
