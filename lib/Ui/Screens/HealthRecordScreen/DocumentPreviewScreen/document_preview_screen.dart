// ignore_for_file: unused_field, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/UploadDocumentModel/upload_document_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/UploadDocument/UploadDocument/upload_document_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/SaveDocumentScreen/save_document_screen.dart';

class DocumentPreviewScreen extends StatefulWidget {
  final File? imageFile;
  final String? imageUrl;
  final int type;

  const DocumentPreviewScreen(
      {Key? key, this.imageFile, this.imageUrl, required this.type})
      : super(key: key);

  @override
  State<DocumentPreviewScreen> createState() => _DocumentPreviewScreenState();
}

class _DocumentPreviewScreenState extends State<DocumentPreviewScreen> {
  late UpLoadDocumentModel upLoadDocumentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Preview'),
      ),
      body: BlocListener<UploadDocumentBloc, UploadDocumentState>(
        listener: (context, state) {
          if (state is UploadDocumentError) {
            const Center(
              child: Text("Something Went Wrong"),
            );
          }
          if (state is UploadDocumentLoaded) {
            upLoadDocumentModel = BlocProvider.of<UploadDocumentBloc>(context)
                .uploadDocumentModel;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DocumentSaveScreen(
                  type: widget.type,
                  documentId: upLoadDocumentModel.document!.id.toString(),
                ),
              ),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.imageFile != null)
                  Image.file(
                    widget.imageFile!,
                    height: 300,
                    width: 300,
                  )
                else if (widget.imageUrl != null)
                  Image.network(
                    widget.imageUrl!,
                    height: 300,
                    width: 300,
                  )
                // SizedBox(
                //   height: 500,
                //   width: 300,
                //   child: PDFView(
                //     filePath: widget.imageUrl,
                //     autoSpacing: true,
                //     pageSnap: true,
                //     swipeHorizontal: true,
                //     onViewCreated: (PDFViewController viewController) {
                //       _pdfViewController = viewController;
                //     },
                //   ),
                // ),
                else
                  const Text('No Image Selected'),
                const VerticalSpacingWidget(height: 50),
                CommonButtonWidget(
                  title: "Upload",
                  onTapFunction: () {
                    print(
                        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${widget.imageFile}");
                    BlocProvider.of<UploadDocumentBloc>(context)
                        .add(FetchUploadDocuments(document: widget.imageFile!));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
