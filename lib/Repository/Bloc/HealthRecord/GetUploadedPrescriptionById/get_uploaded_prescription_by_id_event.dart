part of 'get_uploaded_prescription_by_id_bloc.dart';

@immutable
sealed class GetUploadedPrescriptionByIdEvent {}


class FetchUploadedPrescriptionById extends GetUploadedPrescriptionByIdEvent{
  final String documentId;

  FetchUploadedPrescriptionById({required this.documentId});
}
