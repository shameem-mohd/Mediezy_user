part of 'get_health_symptoms_bloc.dart';

@immutable
sealed class GetHealthSymptomsEvent {}

class FetchAllHealthSymptoms extends GetHealthSymptomsEvent{}
