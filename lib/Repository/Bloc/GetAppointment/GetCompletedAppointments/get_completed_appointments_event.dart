part of 'get_completed_appointments_bloc.dart';

@immutable
sealed class GetCompletedAppointmentsEvent {}

class FetchCompletedAppointments extends GetCompletedAppointmentsEvent {}
