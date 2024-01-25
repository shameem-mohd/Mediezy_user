import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetAllergy/get_allery_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/AddMember/add_member_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllergy/get_allergy_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController illnessController = TextEditingController();
  final TextEditingController medicineController = TextEditingController();
  final TextEditingController drugAllergyController = TextEditingController();
  final TextEditingController skinAllergyController = TextEditingController();
  final TextEditingController foodAllergyController = TextEditingController();
  final TextEditingController otherSurgeryController = TextEditingController();
  final TextEditingController otherTreatmentController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GetAllergyModel getAllergyModel;

  String allergyId = "";
  String dustAllery = "";
  String genderValue = "Male";
  String selectedGender = "1";

  String regularMedicine = "No";
  List<String> selectedSurgery = [];
  List<String> selectedTreatment = [];
  int selectedAllergyStart = -1;
  int selectedDustAlleryStart = -1;
  Set<int> selectedSurgeryStart = <int>{};
  Set<int> selectedTreatmentStart = <int>{};

  String surgeryIndex = "";
  String treatmentIndex = "";

  List<String> treatmentTypes = [
    "Pneumonia",
    "Tuberculosis",
    "Asthma",
    "Covid",
    "No",
    "Other"
  ];

  List<String> dustAlleryTypes = ["Skin", "Rhirits"];

  List<String> surgeryTypes = [
    "Angiogram",
    "Appendectomy",
    "Open Heart Surgery",
    "Fracture",
    "RGP-Stenting",
    "No",
    "Other"
  ];

  @override
  void initState() {
    BlocProvider.of<GetAllergyBloc>(context).add(FetchAllergy());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Family Member"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacingWidget(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: kSubTextColor),
                        ),
                        VerticalSpacingWidget(height: 10.h),
                        SizedBox(
                          width: 250.w,
                          child: TextFormField(
                            cursorColor: kMainColor,
                            controller: fullNameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 16.sp, color: kSubTextColor),
                              hintText: "Enter full name",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Age",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: kSubTextColor),
                        ),
                        VerticalSpacingWidget(height: 10.h),
                        SizedBox(
                          width: 80.w,
                          child: TextFormField(
                            cursorColor: kMainColor,
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Age";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 16.sp, color: kSubTextColor),
                              hintText: "Age",
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
                  ],
                ),
                VerticalSpacingWidget(height: 10.h),
                Text(
                  "Phone Number",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: kSubTextColor),
                ),
                const VerticalSpacingWidget(height: 5),
                TextFormField(
                  cursorColor: kMainColor,
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 10) {
                      return "Phone number is missing";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    counterText: "",
                    hintStyle: TextStyle(fontSize: 16.sp, color: kSubTextColor),
                    hintText: "Enter Mobile Number",
                    filled: true,
                    fillColor: kCardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: kSubTextColor),
                        ),
                        VerticalSpacingWidget(height: 2.h),
                        Row(
                          children: [
                            Radio<String>(
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -2),
                                activeColor: kMainColor,
                                value: "Male",
                                groupValue: genderValue,
                                onChanged: (value) {
                                  setState(() {
                                    genderValue = value!;
                                    selectedGender = 1.toString();
                                  });
                                }),
                            Text("Male", style: TextStyle(fontSize: 12.sp)),
                            Radio<String>(
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -2),
                                activeColor: kMainColor,
                                value: "Female",
                                groupValue: genderValue,
                                onChanged: (value) {
                                  setState(() {
                                    genderValue = value!;
                                    selectedGender = 2.toString();
                                  });
                                }),
                            Text("Female", style: TextStyle(fontSize: 12.sp)),
                            Radio<String>(
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -2),
                                activeColor: kMainColor,
                                value: "Other",
                                groupValue: genderValue,
                                onChanged: (value) {
                                  setState(() {
                                    genderValue = value!;
                                    selectedGender = 3.toString();
                                  });
                                }),
                            Text("Other", style: TextStyle(fontSize: 12.sp)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Relation",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: kSubTextColor),
                        ),
                        VerticalSpacingWidget(height: 2.h),
                        Text(
                          "Family Member",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: kTextColor),
                        )
                      ],
                    ),
                  ],
                ),
                const VerticalSpacingWidget(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Using any regular medicines?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: kSubTextColor),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                  activeColor: kMainColor,
                                  value: "Yes",
                                  groupValue: regularMedicine,
                                  onChanged: (value) {
                                    setState(() {
                                      regularMedicine = value!;
                                    });
                                  }),
                              Text("Yes",
                                  style: TextStyle(
                                      fontSize: 12.sp, color: kSubTextColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                  activeColor: kMainColor,
                                  value: "No",
                                  groupValue: regularMedicine,
                                  onChanged: (value) {
                                    setState(() {
                                      regularMedicine = value!;
                                    });
                                  }),
                              Text("No",
                                  style: TextStyle(
                                      fontSize: 12.sp, color: kSubTextColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const VerticalSpacingWidget(height: 2),
                regularMedicine == "Yes"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.h,
                            width: double.infinity,
                            child: TextFormField(
                              cursorColor: kMainColor,
                              controller: illnessController,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 12.sp, color: kSubTextColor),
                                hintText: "In which illness  eg: Diabiaties..",
                                filled: true,
                                fillColor: kCardColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 5),
                          SizedBox(
                            height: 40.h,
                            width: double.infinity,
                            child: TextFormField(
                              cursorColor: kMainColor,
                              controller: medicineController,
                              onChanged: (value) {},
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 12.sp, color: kSubTextColor),
                                hintText: "Enter Medicine Name",
                                filled: true,
                                fillColor: kCardColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 5),
                        ],
                      )
                    : Container(),

                Text(
                  "Any Allergy?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: kSubTextColor),
                ),
                VerticalSpacingWidget(height: 2.h),
                BlocBuilder<GetAllergyBloc, GetAllergyState>(
                  builder: (context, state) {
                    if (state is GetAllergyLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kCardColor,
                        ),
                      );
                    }
                    if (state is GetAllergyError) {
                      const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                    if (state is GetAllergyLoaded) {
                      getAllergyModel = BlocProvider.of<GetAllergyBloc>(context)
                          .getAllergyModel;
                      return Wrap(
                        children: List.generate(
                          getAllergyModel.allergies!.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAllergyStart =
                                    selectedAllergyStart == index ? -1 : index;
                                allergyId = getAllergyModel.allergies![index].id
                                    .toString();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectedAllergyStart == index
                                    ? Colors.grey
                                    : kCardColor,
                                border: Border.all(color: kMainColor, width: 1),
                              ),
                              margin: const EdgeInsets.all(3.0),
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                getAllergyModel.allergies![index].allergy
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9.8.sp,
                                  color: selectedAllergyStart == index
                                      ? Colors.white
                                      : kTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                const VerticalSpacingWidget(height: 2),
                //! drug allergy
                if (selectedAllergyStart == 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Which Drug",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      const VerticalSpacingWidget(height: 2),
                      SizedBox(
                        height: 40.h,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: drugAllergyController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 12.sp, color: kSubTextColor),
                            hintText: "Enter Drug Name",
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
                //! skin allergy
                if (selectedAllergyStart == 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "In which situation",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      const VerticalSpacingWidget(height: 2),
                      SizedBox(
                        height: 40.h,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: skinAllergyController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 12.sp, color: kSubTextColor),
                            hintText: "in which situation",
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
                if (selectedAllergyStart == 2)
                  Center(
                    child: Wrap(
                      children: List.generate(
                        dustAlleryTypes.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDustAlleryStart =
                                  selectedDustAlleryStart == index ? -1 : index;
                              dustAllery = dustAlleryTypes[index];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedDustAlleryStart == index
                                  ? Colors.grey
                                  : kCardColor,
                              border: Border.all(color: kMainColor, width: 1),
                            ),
                            margin: const EdgeInsets.all(3.0),
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              dustAlleryTypes[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 9.8.sp,
                                color: selectedDustAlleryStart == index
                                    ? Colors.white
                                    : kTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                //! food allergy
                if (selectedAllergyStart == 3)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Which Food"),
                      const VerticalSpacingWidget(height: 2),
                      SizedBox(
                        height: 40.h,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: foodAllergyController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 12.sp, color: kSubTextColor),
                            hintText: "in which food",
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
                //! surgery
                Text(
                  "Any Surgery?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: kSubTextColor),
                ),
                VerticalSpacingWidget(height: 2.h),
                Wrap(
                  children: List.generate(
                    surgeryTypes.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedSurgeryStart.contains(index)) {
                            surgeryIndex = "";
                            selectedSurgery.remove(surgeryTypes[index]);
                            selectedSurgeryStart.remove(index);
                          } else {
                            surgeryIndex = surgeryTypes[index];
                            selectedSurgeryStart.add(index);
                            selectedSurgery.add(surgeryTypes[index]);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedSurgeryStart.contains(index)
                              ? Colors.grey
                              : kCardColor,
                          border: Border.all(
                            color: kMainColor,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          surgeryTypes[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: selectedSurgeryStart.contains(index)
                                ? Colors.white
                                : kTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                if (surgeryIndex == "Other")
                  SizedBox(
                    height: 40.h,
                    child: TextFormField(
                      cursorColor: kMainColor,
                      controller: otherSurgeryController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 12.sp, color: kSubTextColor),
                        hintText: "Which Surgery",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                const VerticalSpacingWidget(height: 5),
                //! treatment taken
                Text(
                  "Any Treatment taken for?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: kSubTextColor),
                ),
                VerticalSpacingWidget(height: 2.h),
                Wrap(
                  children: List.generate(
                    treatmentTypes.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedTreatmentStart.contains(index)) {
                            treatmentIndex = "";
                            selectedTreatment.remove(treatmentTypes[index]);
                            selectedTreatmentStart.remove(index);
                          } else {
                            treatmentIndex = treatmentTypes[index];
                            selectedTreatmentStart.add(index);
                            selectedTreatment.add(treatmentTypes[index]);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedTreatmentStart.contains(index)
                              ? Colors.grey
                              : kCardColor,
                          border: Border.all(
                            color: kMainColor,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          treatmentTypes[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: selectedTreatmentStart.contains(index)
                                ? Colors.white
                                : kTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                if (treatmentIndex == "Other")
                  SizedBox(
                    height: 40.h,
                    child: TextFormField(
                      cursorColor: kMainColor,
                      controller: otherTreatmentController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 12.sp, color: kSubTextColor),
                        hintText: "Which Treatment",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                const VerticalSpacingWidget(height: 5),
                VerticalSpacingWidget(height: 20.h),
                CommonButtonWidget(
                    title: "Add Member",
                    onTapFunction: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AddMemberBloc>(context).add(
                          FetchAddMember(
                            fullName: fullNameController.text,
                            age: ageController.text,
                            relation: "2",
                            gender: selectedGender,
                            mobileNumber: phoneNumberController.text,
                            regularMedicine: regularMedicine,
                            illness: regularMedicine == "Yes"
                                ? illnessController.text
                                : null.toString(),
                            medicineTaken: regularMedicine == "Yes"
                                ? medicineController.text
                                : null.toString(),
                            allergyId: allergyId,
                            allergyName: (allergyId == "1")
                                ? drugAllergyController.text
                                : (allergyId == "2")
                                    ? skinAllergyController.text
                                    : (allergyId == "3")
                                        ? dustAllery
                                        : (allergyId == "4")
                                            ? foodAllergyController.text
                                            : "No",
                            surgeyName: surgeryIndex == "Other"
                                ? otherSurgeryController.text
                                : selectedSurgery.toString(),
                            treatmentTaken: treatmentIndex == "Other"
                                ? otherTreatmentController.text
                                : selectedTreatment.toString(),
                          ),
                        );
                        // Navigator.pop(context, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavigationControlWidget(),
                          ),
                        );
                      }
                    }),
                VerticalSpacingWidget(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
