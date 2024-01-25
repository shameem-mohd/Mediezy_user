import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetAllMembers/get_all_members_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllMembers/get_all_members_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/UploadDocument/UploadDocumentFinal/upload_document_lab_and_scan_final_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class DocumentSaveScreen extends StatefulWidget {
  const DocumentSaveScreen(
      {super.key, required this.type, required this.documentId});

  final int type;
  final String documentId;

  @override
  State<DocumentSaveScreen> createState() => _DocumentSaveScreenState();
}

class _DocumentSaveScreenState extends State<DocumentSaveScreen> {
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController fileNameController = TextEditingController();
  final TextEditingController additionalNoteController =
      TextEditingController();
  final TextEditingController labTextNameController = TextEditingController();
  final TextEditingController labNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  late GetAllMembersModel getAllMembersModel;
  late ValueNotifier<String> dropValueNotifier;
  String dropValue1 = "";
  late String selectedPatientId;
  List<PatientsData> patientNames = [];

  @override
  void initState() {
    BlocProvider.of<GetAllMembersBloc>(context).add(FetchAllMembers());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document Details"),
        centerTitle: true,
      ),
      body: BlocListener<UploadDocumentFinalBloc, UploadDocumentFinalState>(
        listener: (context, state) {
          if (state is UploadDocumentFinalLoaded) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const BottomNavigationControlWidget(),
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacingWidget(height: 10),
                  Text(
                    "Patient Name",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: kSubTextColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  BlocBuilder<GetAllMembersBloc, GetAllMembersState>(
                    builder: (context, state) {
                      if (state is GetAllMembersLoaded) {
                        getAllMembersModel =
                            BlocProvider.of<GetAllMembersBloc>(context)
                                .getAllMembersModel;
                        if (patientNames.length <= 1) {
                          patientNames.addAll(getAllMembersModel.patientsData!);
                          dropValueNotifier = ValueNotifier(
                              patientNames.first.firstname.toString());
                          dropValue1 = patientNames.first.id.toString();
                          selectedPatientId = patientNames.first.id.toString();
                        }
                        return Container(
                          height: 40.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: kCardColor,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: const Color(0xFF9C9C9C))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Center(
                              child: ValueListenableBuilder(
                                valueListenable: dropValueNotifier,
                                builder: (BuildContext context,
                                    String dropValue, _) {
                                  return DropdownButtonFormField(
                                    iconEnabledColor: kMainColor,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    value: dropValue,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: kTextColor),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    onChanged: (String? value) {
                                      dropValue = value!;
                                      dropValueNotifier.value = value;
                                      dropValue1 = value;
                                      selectedPatientId = patientNames
                                          .where((element) => element.firstname!
                                              .contains(value))
                                          .toList()
                                          .first
                                          .id
                                          .toString();
                                    },
                                    items: patientNames
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                        onTap: () {
                                          setState(() {
                                            dropValue1 = value.id.toString();
                                          });
                                        },
                                        value: value.firstname!,
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
                  Text(
                    "Basic Details",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: kTextColor,
                        fontWeight: FontWeight.w700),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Record Date",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: kSubTextColor,
                                fontWeight: FontWeight.w400),
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Container(
                            height: 60.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: kCardColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      selectDate(
                                        context: context,
                                        date: selectedDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            selectedDate = picked;
                                          });
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.calendar_month_outlined,
                                      color: kMainColor,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      widget.type == 2
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Prescribed By",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: kSubTextColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                SizedBox(
                                  width: 220.w,
                                  child: TextFormField(
                                    cursorColor: kMainColor,
                                    controller: doctorNameController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Doctor Name is missing";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: kSubTextColor),
                                      hintText: "Dr.",
                                      filled: true,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lab Test Name",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: kSubTextColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                SizedBox(
                                  width: 205.w,
                                  child: TextFormField(
                                    cursorColor: kMainColor,
                                    controller: labTextNameController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Test Name is missing";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: kSubTextColor),
                                      hintText: "Enter Lab test Name",
                                      filled: true,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                  const VerticalSpacingWidget(height: 10),
                  widget.type == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Lab Name",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: kSubTextColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            const VerticalSpacingWidget(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                cursorColor: kMainColor,
                                controller: labNameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Lab Name is missing";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: 15.sp, color: kSubTextColor),
                                  hintText: "Enter Lab Name",
                                  filled: true,
                                  fillColor: kCardColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const VerticalSpacingWidget(height: 10),
                          ],
                        )
                      : Container(),
                  Text(
                    "Additional Details",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: kTextColor,
                        fontWeight: FontWeight.w700),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  widget.type == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "File Name",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: kSubTextColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                SizedBox(
                                  width: 150.w,
                                  child: TextFormField(
                                    cursorColor: kMainColor,
                                    controller: fileNameController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: kSubTextColor),
                                      hintText: "Enter File Name",
                                      filled: true,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Doctor Name",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: kSubTextColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                SizedBox(
                                  width: 180.w,
                                  child: TextFormField(
                                    cursorColor: kMainColor,
                                    controller: doctorNameController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Doctor Name is missing";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: kSubTextColor),
                                      hintText: "Enter Doctor Name",
                                      filled: true,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "File Name",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: kSubTextColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            const VerticalSpacingWidget(height: 5),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                cursorColor: kMainColor,
                                controller: fileNameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: 15.sp, color: kSubTextColor),
                                  hintText: "Enter File Name",
                                  filled: true,
                                  fillColor: kCardColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  const VerticalSpacingWidget(height: 5),
                  Divider(color: kSubTextColor, height: 5.h),
                  const VerticalSpacingWidget(height: 5),
                  Text(
                    "Additional Note",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: kSubTextColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: kMainColor,
                      controller: additionalNoteController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: "Enter Additional Notes",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  CommonButtonWidget(
                      title: "Save",
                      onTapFunction: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<UploadDocumentFinalBloc>(context).add(
                            UploadDocumentFinal(
                                documentId: widget.documentId,
                                patientId: dropValue1.toString(),
                                type: widget.type.toString(),
                                doctorName: doctorNameController.text,
                                date: selectedDate.toString(),
                                fileName: fileNameController.text,
                                testName: labTextNameController.text,
                                labName: labNameController.text,
                                notes: additionalNoteController.text),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //* for select date
  Future<void> selectDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: ((context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kMainColor,
            ),
          ),
          child: child!,
        );
      }),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }
}
