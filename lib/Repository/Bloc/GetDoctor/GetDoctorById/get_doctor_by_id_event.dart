part of 'get_doctor_by_id_bloc.dart';

@immutable
sealed class GetDoctorByIdEvent {}

class FetchDoctorById extends GetDoctorByIdEvent {
  final String id;

  FetchDoctorById({required this.id});
}
