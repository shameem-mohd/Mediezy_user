part of 'get_all_uploaded_documents_bloc.dart';

@immutable
sealed class GetAllUploadedDocumentsEvent {}

class FetchAllUploadedDocuments extends GetAllUploadedDocumentsEvent {
  final String patientId;

  FetchAllUploadedDocuments({required this.patientId});
}
