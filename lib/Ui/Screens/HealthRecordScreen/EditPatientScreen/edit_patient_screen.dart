import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetMemberAsPerId/get_member_as_per_id_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/EditMember/edit_member_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetMemberById/get_member_by_id_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class EditPatientScreen extends StatefulWidget {
  const EditPatientScreen(
      {Key? key, required this.patientId, required this.gender})
      : super(key: key);

  final String patientId;
  final String gender;

  @override
  State<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String genderValue = "";
  String selectedGender = "";
  late GetMemberAsPerIdModel getMemberAsPerIdModel;

  @override
  void initState() {
    BlocProvider.of<GetMemberByIdBloc>(context)
        .add(FetchMemberById(patientId: widget.patientId));
    genderValue = widget.gender == "1" ? "Male" : "Female";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Patient"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: BlocBuilder<GetMemberByIdBloc, GetMemberByIdState>(
          builder: (context, state) {
            if (state is GetMemberByIdLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: kMainColor,
                ),
              );
            }
            if (state is GetMemberByIdError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            if (state is GetMemberByIdLoaded) {
              getMemberAsPerIdModel =
                  BlocProvider.of<GetMemberByIdBloc>(context)
                      .getMemberAsPerIdModel;
        
              return Column(
                children: [
                  const VerticalSpacingWidget(height: 10),
                  TextFormField(
                    cursorColor: kMainColor,
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        IconlyLight.profile,
                        color: kMainColor,
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15.sp, color: kSubTextColor),
                      hintText: getMemberAsPerIdModel.patientData!.firstname,
                      filled: true,
                      fillColor: kCardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  TextFormField(
                    cursorColor: kMainColor,
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        IconlyLight.infoSquare,
                        color: kMainColor,
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15.sp, color: kSubTextColor),
                      hintText:
                          getMemberAsPerIdModel.patientData!.age.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Radio<String>(
                        activeColor: kMainColor,
                        value: "Male",
                        groupValue: genderValue,
                        onChanged: (value) {
                          setState(() {
                            genderValue = value!;
                            selectedGender = "1";
                          });
                        },
                      ),
                      const Text("Male"),
                      Radio<String>(
                        activeColor: kMainColor,
                        value: "Female",
                        groupValue: genderValue,
                        onChanged: (value) {
                          setState(() {
                            genderValue = value!;
                            selectedGender = "2";
                          });
                        },
                      ),
                      const Text("Female"),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 30),
                  CommonButtonWidget(
                      title: "Update",
                      onTapFunction: () {
                        BlocProvider.of<EditMemberBloc>(context)
                            .add(FetchEditMember(
                          patientId: widget.patientId,
                          age: ageController.text,
                          fullName: nameController.text,
                          gender: selectedGender,
                        ));
                        Navigator.pop(context,true);
                      })
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
