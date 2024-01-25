part of 'upload_document_lab_and_scan_final_bloc.dart';

@immutable
abstract class UploadDocumentFinalEvent {}

class UploadDocumentFinal extends UploadDocumentFinalEvent {
  final String documentId;
  final String patientId;
  final String type;
  final String doctorName;
  final String date;
  final String fileName;
  final String testName;
  final String labName;
  final String notes;
  UploadDocumentFinal({
    required this.documentId,
    required this.patientId,
    required this.type,
    required this.doctorName,
    required this.date,
    required this.fileName,
    required this.testName,
    required this.labName,
    required this.notes,
  });
}

//edit image document lab and prescription

class EditImageDocument extends UploadDocumentFinalEvent {
  final String documentId;
  final String type;
  final File document;

  EditImageDocument({
    required this.documentId,
    required this.type,
    required this.document,
  });
}
