part of 'get_symptoms_bloc.dart';

@immutable
abstract class GetSymptomsState {}

class GetSymptomsInitial extends GetSymptomsState {}
final class GetSymptomsLoading extends GetSymptomsState {}

final class GetSymptomsLoaded extends GetSymptomsState {}

final class GetSymptomsError extends GetSymptomsState {}