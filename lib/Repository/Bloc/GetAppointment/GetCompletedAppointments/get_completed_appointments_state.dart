part of 'get_completed_appointments_bloc.dart';

@immutable
sealed class GetCompletedAppointmentsState {}

final class GetCompletedAppointmentsInitial extends GetCompletedAppointmentsState {}

class GetCompletedAppointmentLoading extends GetCompletedAppointmentsState{}
class GetCompletedAppointmentLoaded extends GetCompletedAppointmentsState{}
class GetCompletedAppointmentError extends GetCompletedAppointmentsState{}
