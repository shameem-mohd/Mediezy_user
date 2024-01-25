part of 'get_all_prescriptions_bloc.dart';

@immutable
sealed class GetAllPrescriptionsEvent {}

class FetchUploadedPrescriptions extends GetAllPrescriptionsEvent {
  final String patientId;

  FetchUploadedPrescriptions({required this.patientId});
}
