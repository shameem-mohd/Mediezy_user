part of 'get_symptoms_bloc.dart';

@immutable
abstract class GetSymptomsEvent {}

class FetchSymptoms extends GetSymptomsEvent {
  final String doctorId;
  FetchSymptoms({
    required this.doctorId
});
}