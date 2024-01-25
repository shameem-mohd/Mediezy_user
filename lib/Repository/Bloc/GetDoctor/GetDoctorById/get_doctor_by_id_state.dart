part of 'get_doctor_by_id_bloc.dart';

@immutable
sealed class GetDoctorByIdState {}

final class GetDoctorByIdInitial extends GetDoctorByIdState {}

class GetDoctorByIdLoading extends GetDoctorByIdState{}

class GetDoctorByIdLoaded extends GetDoctorByIdState{}

class GetDoctorByIdError extends GetDoctorByIdState{}

