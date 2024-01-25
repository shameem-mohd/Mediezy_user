// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediezy_user/Model/GetUploadedLabAndScanById/get_uploaded_lob_and_scan_by_id_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetUploadedLabAndScanById/get_uploaded_scan_and_lab_by_id_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/UploadDocument/UploadDocumentFinal/upload_document_lab_and_scan_final_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';

class EditLabAndScanScreen extends StatefulWidget {
  const EditLabAndScanScreen(
      {super.key,
      required this.documentId,
      required this.patientId,
      required this.type});

  final String documentId;
  final String patientId;
  final String type;

  @override
  State<EditLabAndScanScreen> createState() => _EditLabAndScanScreenState();
}

class _EditLabAndScanScreenState extends State<EditLabAndScanScreen> {
  late GetUploadedScanAndLabByIdModel getUploadedScanAndLabByIdModel;
  final TextEditingController testNameController = TextEditingController();
  final TextEditingController labNameController = TextEditingController();
  final TextEditingController fileNameController = TextEditingController();

  // final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController drNameController = TextEditingController();
  final TextEditingController additionalNoteController =
      TextEditingController();
  File? imageFromGallery;
  File? imageFromCamera;

  @override
  void initState() {
    BlocProvider.of<GetUploadedScanAndLabByIdBloc>(context).add(
      FetchUploadedScanAndLabById(documentId: widget.documentId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Edit Lab and Scan Report"),
          centerTitle: true,
        ),
        body: BlocListener<UploadDocumentFinalBloc, UploadDocumentFinalState>(
          listener: (context, state) {
            if (state is UploadDocumentFinalLoaded) {
              BlocProvider.of<GetUploadedScanAndLabByIdBloc>(context).add(
                FetchUploadedScanAndLabById(documentId: widget.documentId),
              );
            }
          },
          child: BlocBuilder<GetUploadedScanAndLabByIdBloc,
              GetUploadedScanAndLabByIdState>(
            builder: (context, state) {
              if (state is GetUploadedScanAndLabByIdLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: kMainColor,
                  ),
                );
              }
              if (state is GetUploadedScanAndLabByIdError) {
                return Center(
                  child: Image(
                    image: const AssetImage(
                        "assets/images/something went wrong-01.png"),
                    height: 200.h,
                    width: 200.w,
                  ),
                );
              }
              if (state is GetUploadedScanAndLabByIdLoaded) {
                getUploadedScanAndLabByIdModel =
                    BlocProvider.of<GetUploadedScanAndLabByIdBloc>(context)
                        .getUploadedScanAndLabByIdModel;
                drNameController.text = getUploadedScanAndLabByIdModel
                    .healthRecord!.doctorName
                    .toString();
                labNameController.text = getUploadedScanAndLabByIdModel
                    .healthRecord!.labName
                    .toString();
                fileNameController.text = getUploadedScanAndLabByIdModel
                    .healthRecord!.fileName
                    .toString();
                testNameController.text = getUploadedScanAndLabByIdModel
                    .healthRecord!.testName
                    .toString();
                additionalNoteController.text = getUploadedScanAndLabByIdModel
                    .healthRecord!.notes
                    .toString();
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpacingWidget(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 200.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  getUploadedScanAndLabByIdModel
                                      .healthRecord!.document
                                      .toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // //! camera
                            // InkWell(
                            //   onTap: () {
                            //     pickImageFromCamera();
                            //   },
                            //   child: Container(
                            //     padding: const EdgeInsets.all(4),
                            //     height: 40.h,
                            //     width: 160.w,
                            //     decoration: BoxDecoration(
                            //       color: kMainColor,
                            //       borderRadius: BorderRadius.circular(5),
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //       children: [
                            //         Image(
                            //           image: const AssetImage(
                            //               "assets/icons/camera.png"),
                            //           color: Colors.white,
                            //           height: 32.h,
                            //         ),
                            //         Text(
                            //           "Camera",
                            //           style: TextStyle(
                            //               fontSize: 17.sp,
                            //               fontWeight: FontWeight.w500,
                            //               color: Colors.white),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            //! gallery
                            InkWell(
                              onTap: () {
                                pickImageFromGallery();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                height: 40.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  color: kMainColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          "assets/icons/gallery.png"),
                                      color: Colors.white,
                                      height: 32.h,
                                    ),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Text(
                          "Record Date : ${getUploadedScanAndLabByIdModel.healthRecord!.date}",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Text(
                          "Doctor Name",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        TextFormField(
                          cursorColor: kMainColor,
                          controller: drNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: kSubTextColor),
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Text(
                          "Lab Name",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        TextFormField(
                          cursorColor: kMainColor,
                          controller: labNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: kSubTextColor),
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Text(
                          "File Name",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        TextFormField(
                          cursorColor: kMainColor,
                          controller: fileNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: kSubTextColor),
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Text(
                          "Test Name",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        TextFormField(
                          cursorColor: kMainColor,
                          controller: testNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: kSubTextColor),
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Text(
                          "Additional Note",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        TextFormField(
                          cursorColor: kMainColor,
                          controller: additionalNoteController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 20),
                        CommonButtonWidget(
                            title: "Update",
                            onTapFunction: () {
                              BlocProvider.of<UploadDocumentFinalBloc>(context)
                                  .add(
                                UploadDocumentFinal(
                                    documentId: widget.documentId,
                                    patientId: widget.patientId,
                                    type: "1",
                                    doctorName: drNameController.text,
                                    date: getUploadedScanAndLabByIdModel
                                        .healthRecord!.date
                                        .toString(),
                                    fileName: fileNameController.text,
                                    testName: testNameController.text,
                                    labName: labNameController.text,
                                    notes: additionalNoteController.text),
                              );
                              BlocProvider.of<UploadDocumentFinalBloc>(context)
                                  .add(EditImageDocument(
                                      documentId: widget.documentId,
                                      type: "1",
                                      document: imageFromGallery!));
                            }),
                        const VerticalSpacingWidget(height: 20),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File compressedImage = await compressImage(pickedFile.path);
      imageFromGallery = await compressImage(pickedFile.path);
    } else {
      GeneralServices.instance.showToastMessage('No image selected');
    }
  }

  //* pick image from camera
  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      try {
        File compressedImage = await compressImage(pickedFile.path);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DocumentPreviewScreen(
        //       imageFile: compressedImage,
        //       type: widget.type,
        //     ),
        //   ),
        // );
      } catch (e) {
        print('Error compressing image: $e');
        GeneralServices.instance.showToastMessage('Error compressing image');
      }
    } else {
      GeneralServices.instance.showToastMessage('No image selected');
    }
  }

  //* Image compression function
  Future<File> compressImage(String imagePath) async {
    File imageFile = File(imagePath);
    int fileSize = await imageFile.length();
    int maxFileSize = 2048 * 1024;
    if (fileSize <= maxFileSize) {
      return imageFile;
    }
    Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
      imagePath,
      quality: 85,
    );
    if (compressedBytes != null) {
      List<int> compressedList = compressedBytes.toList();
      File compressedImage = File(imagePath)..writeAsBytesSync(compressedList);
      return compressedImage;
    } else {
      throw Exception('Image compression failed');
    }
  }
}
