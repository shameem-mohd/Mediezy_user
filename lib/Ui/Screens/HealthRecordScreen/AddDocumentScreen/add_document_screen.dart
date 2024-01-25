// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/DocumentPreviewScreen/document_preview_screen.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';

class AddDocumentScreen extends StatefulWidget {
  const AddDocumentScreen(
      {super.key,
      required this.appBarTitle,
      required this.stringType,
      required this.type});

  final String appBarTitle;
  final String stringType;
  final int type;

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  File? imageFromGallery;
  File? imageFromCamera;
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: kScaffoldColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.error,
                          size: 30.sp,
                        ),
                        const HorizontalSpacingWidget(width: 10),
                        Text(
                          "What is valid ${widget.stringType}?\nWhy upload a ${widget.stringType}",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const VerticalSpacingWidget(height: 50),
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 26.sp,
                        ),
                        const HorizontalSpacingWidget(width: 10),
                        Text(
                          "Our team will verify your ${widget.stringType} and\ncall back to confirm your lab test order",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const VerticalSpacingWidget(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.smartphone_outlined,
                          size: 26.sp,
                        ),
                        const HorizontalSpacingWidget(width: 10),
                        Text(
                          "Your ${widget.stringType} will always available in\nyour account so that you can access it anytime\nanywhare",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const VerticalSpacingWidget(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 26.sp,
                        ),
                        const HorizontalSpacingWidget(width: 10),
                        Text(
                          "Details from your ${widget.stringType} are only\nvisible to our team of specialist",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacingWidget(height: 50),
                      Text(
                        "Upload ${widget.stringType} from",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      const VerticalSpacingWidget(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //! camera
                          InkWell(
                            onTap: () {
                              pickImageFromCamera();
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
                                        "assets/icons/camera.png"),
                                    color: Colors.white,
                                    height: 32.h,
                                  ),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                      //! file
                      // InkWell(
                      //   onTap: () {
                      //     pickFile();
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.all(4),
                      //     height: 40.h,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       color: kMainColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image(
                      //           image:
                      //               const AssetImage("assets/icons/file.png"),
                      //           color: Colors.white,
                      //           height: 32.h,
                      //         ),
                      //         const HorizontalSpacingWidget(width: 10),
                      //         Text(
                      //           "File",
                      //           style: TextStyle(
                      //               fontSize: 17.sp,
                      //               fontWeight: FontWeight.w500,
                      //               color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //* pick image from gallery
  Future pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() async {
      if (pickedFile != null) {
        // Compress the selected image
        imageFromGallery = await compressImage(pickedFile.path);

        // Navigate to DocumentPreviewScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentPreviewScreen(
              imageFile: imageFromGallery!,
              type: widget.type,
            ),
          ),
        );
      } else {
        GeneralServices.instance.showToastMessage('No image selected');
      }
    });
  }

  //* pick image from camera
  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      try {
        File compressedImage = await compressImage(pickedFile.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentPreviewScreen(
              imageFile: compressedImage,
              type: widget.type,
            ),
          ),
        );
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
  //*pick file from mobile
  // Future<void> pickFile() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles();
  //     if (result != null) {
  //       String path = result.files.single.path!;
  //       setState(() {
  //         filePath = path;
  //         print("<<<<PICK FILE PATH>>>>>>> $filePath");
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) =>
  //                 DocumentPreviewScreen(imageUrl: filePath!, type: widget.type),
  //           ),
  //         );
  //       });
  //     } else {
  //       // User canceled the file picker
  //     }
  //   } catch (e) {
  //     print('Error picking file: $e');
  //   }
  // }

