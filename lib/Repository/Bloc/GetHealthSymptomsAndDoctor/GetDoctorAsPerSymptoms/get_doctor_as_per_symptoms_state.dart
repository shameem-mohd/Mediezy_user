part of 'get_doctor_as_per_symptoms_bloc.dart';

@immutable
sealed class GetDoctorAsPerSymptomsState {}

final class GetDoctorAsPerSymptomsInitial extends GetDoctorAsPerSymptomsState {}

class GetDoctorsAsperHealthSymptomsLoading extends GetDoctorAsPerSymptomsState{}

class GetDoctorsAsperHealthSymptomsLoaded extends GetDoctorAsPerSymptomsState{}

class GetDoctorsAsperHealthSymptomsError extends GetDoctorAsPerSymptomsState{}
