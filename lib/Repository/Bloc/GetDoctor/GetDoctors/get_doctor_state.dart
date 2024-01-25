part of 'get_doctor_bloc.dart';

@immutable
abstract class GetDoctorState {}

final class GetDoctorInitial extends GetDoctorState {}

class GetDoctorLoading extends GetDoctorState {}
class GetDoctorLoaded extends GetDoctorState {}
class GetDoctorError extends GetDoctorState {}



