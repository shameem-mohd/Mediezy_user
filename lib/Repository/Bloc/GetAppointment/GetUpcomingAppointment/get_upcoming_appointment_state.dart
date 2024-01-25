part of 'get_upcoming_appointment_bloc.dart';

@immutable
sealed class GetUpcomingAppointmentState {}

final class GetUpcomingAppointmentInitial extends GetUpcomingAppointmentState {}

class GetUpComingAppointmentLoading extends GetUpcomingAppointmentState {}

class GetUpComingAppointmentLoaded extends GetUpcomingAppointmentState {
  final bool isLoaded;

  GetUpComingAppointmentLoaded({required this.isLoaded});
}

class GetUpComingAppointmentError extends GetUpcomingAppointmentState {}
