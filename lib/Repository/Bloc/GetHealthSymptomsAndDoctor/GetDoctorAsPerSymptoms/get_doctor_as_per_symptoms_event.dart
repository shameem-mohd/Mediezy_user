part of 'get_doctor_as_per_symptoms_bloc.dart';

@immutable
sealed class GetDoctorAsPerSymptomsEvent {}

class FetchDoctorAsPerHealthSymptoms extends GetDoctorAsPerSymptomsEvent {
  final String id;

  FetchDoctorAsPerHealthSymptoms({required this.id});
}
