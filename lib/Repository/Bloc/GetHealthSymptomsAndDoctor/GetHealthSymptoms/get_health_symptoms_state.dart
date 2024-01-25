part of 'get_health_symptoms_bloc.dart';

@immutable
sealed class GetHealthSymptomsState {}

final class GetHealthSymptomsInitial extends GetHealthSymptomsState {}


class GetHealthSymptomsLoading extends GetHealthSymptomsState{}

class GetHealthSymptomsLoaded extends GetHealthSymptomsState{}

class GetHealthSymptomsError extends GetHealthSymptomsState{}
