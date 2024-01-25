part of 'get_recently_booked_doctors_bloc.dart';

@immutable
sealed class GetRecentlyBookedDoctorsState {}

final class GetRecentlyBookedDoctorsInitial extends GetRecentlyBookedDoctorsState {}

class GetRecentlyBookedDoctorLoading extends GetRecentlyBookedDoctorsState{}
class GetRecentlyBookedDoctorLoaded extends GetRecentlyBookedDoctorsState{}
class GetRecentlyBookedDoctorError extends GetRecentlyBookedDoctorsState{}

