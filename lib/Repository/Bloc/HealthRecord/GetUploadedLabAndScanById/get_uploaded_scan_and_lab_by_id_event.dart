part of 'get_uploaded_scan_and_lab_by_id_bloc.dart';

@immutable
sealed class GetUploadedScanAndLabByIdEvent {}

class FetchUploadedScanAndLabById extends GetUploadedScanAndLabByIdEvent {
  final String documentId;

  FetchUploadedScanAndLabById({required this.documentId});
}
