import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/UploadDocumentApi.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'upload_document_lab_and_scan_final_event.dart';
part 'upload_document_lab_and_scan_final_state.dart';

class UploadDocumentFinalBloc
    extends Bloc<UploadDocumentFinalEvent, UploadDocumentFinalState> {
  late String updatedSuccessfully;
  UploadDocumentApi uploadDocumentsApi = UploadDocumentApi();
  UploadDocumentFinalBloc() : super(UploadDocumentFinalInitial()) {
    on<UploadDocumentFinal>((event, emit) async {
      emit(UploadDocumentFinalLoading());
      try {
        updatedSuccessfully = await uploadDocumentsApi.uploadDocumentFinal(
            documentId: event.documentId,
            patientId: event.patientId,
            doctorName: event.doctorName,
            date: event.date,
            fileName: event.fileName,
            testName: event.testName,
            labName: event.labName,
            notes: event.notes,
            type: event.type);
        emit(UploadDocumentFinalLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['response']);
      } catch (error) {
        print("<<<<Error>>>>>>>>>>" + error.toString());
        emit(UploadDocumentFinalError());
      }
    });

    
    on<EditImageDocument>((event, emit) async {
      emit(UploadDocumentFinalLoading());
      try {
        updatedSuccessfully = await uploadDocumentsApi.editImageDocument(
            documentId: event.documentId,
            type: event.type,
            document: event.document);
        emit(UploadDocumentFinalLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['response']);
      } catch (error) {
        print("<<<<Error>>>>>>>>>>" + error.toString());
        emit(UploadDocumentFinalError()); 
      }
    });
  }
}
