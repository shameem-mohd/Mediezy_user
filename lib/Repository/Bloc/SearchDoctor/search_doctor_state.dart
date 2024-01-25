part of 'search_doctor_bloc.dart';

@immutable
sealed class SearchDoctorState {}

final class SearchDoctorInitial extends SearchDoctorState {}


class SearchDoctorLoading extends SearchDoctorState{}

class SearchDoctorLoaded extends SearchDoctorState{}

class SearchDoctorError extends SearchDoctorState{}
