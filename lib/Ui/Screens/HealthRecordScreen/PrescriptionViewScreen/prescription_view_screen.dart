import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetPrescriptionView/get_prescription_view_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetPrescriptionView/get_prescription_view_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/ViewFileScreen/view_file_screen.dart';

class PrescriptionViewScreen extends StatefulWidget {
  const PrescriptionViewScreen({
    super.key,
    required this.name,
    required this.patientId,
  });
  final String name;
  final String patientId;

  @override
  State<PrescriptionViewScreen> createState() => _PrescriptionViewScreenState();
}

class _PrescriptionViewScreenState extends State<PrescriptionViewScreen> {
  late GetPrescriptionViewModel getPrescriptionViewModel;

  @override
  void initState() {
    BlocProvider.of<GetPrescriptionViewBloc>(context)
        .add(FetchGetPrescriptionView(
      patientId: widget.patientId,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: BlocBuilder<GetPrescriptionViewBloc, GetPrescriptionViewState>(
        builder: (context, state) {
          if (state is GetPrescriptionViewLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetPrescriptionViewError) {
            return Center(
              child: Image(
                image: const AssetImage(
                    "assets/images/something went wrong-01.png"),
                height: 250.h,
                width: 250.w,
              ),
            );
          }
          if (state is GetPrescriptionViewLoaded) {
            getPrescriptionViewModel =
                BlocProvider.of<GetPrescriptionViewBloc>(context)
                    .getPrescriptionViewModel;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      "Prescriptions (${getPrescriptionViewModel.prescriptions!.length})",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  VerticalSpacingWidget(height: 10.h),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: getPrescriptionViewModel.prescriptions!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const VerticalSpacingWidget(height: 3),
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kCardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const VerticalSpacingWidget(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: kMainColor,
                                        ),
                                        HorizontalSpacingWidget(width: 5.w),
                                        Text(
                                          getPrescriptionViewModel
                                              .prescriptions![index]
                                              .patientPrescription!
                                              .first
                                              .date
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Image(
                                      image: const AssetImage(
                                        "assets/icons/image.png",
                                      ),
                                      height: 25.h,
                                      width: 25.w,
                                    )
                                  ],
                                ),
                                const VerticalSpacingWidget(height: 5),
                                Text(
                                  "Dr. ${getPrescriptionViewModel.prescriptions![index].patientPrescription!.first.doctorName.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => ViewFileScreen(
                                          viewFile: getPrescriptionViewModel
                                              .prescriptions![index]
                                              .documentPath
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 400.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                height: 30.h,
                                                width: 30.w,
                                                image: const AssetImage(
                                                  "assets/icons/image.png",
                                                ),
                                              ),
                                              HorizontalSpacingWidget(
                                                  width: 5.w),
                                              Text(
                                                getPrescriptionViewModel
                                                    .prescriptions![index]
                                                    .patientPrescription!
                                                    .first
                                                    .fileName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 17,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalSpacingWidget(height: 5),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
