part of 'get_doctors_as_per_specialisation_bloc.dart';

@immutable
sealed class GetDoctorsAsPerSpecialisationEvent {}

class FetchDocterAsperSpecialisaton extends GetDoctorsAsPerSpecialisationEvent {
  final String id;

  FetchDocterAsperSpecialisaton({required this.id});
}
