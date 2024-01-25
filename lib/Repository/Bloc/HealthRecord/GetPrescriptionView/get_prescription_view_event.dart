part of 'get_prescription_view_bloc.dart';

@immutable
sealed class GetPrescriptionViewEvent {}

class FetchGetPrescriptionView extends GetPrescriptionViewEvent {
  final String patientId;

  FetchGetPrescriptionView({
    required this.patientId,
  });
}
