part of 'get_recently_booked_doctors_bloc.dart';

@immutable
sealed class GetRecentlyBookedDoctorsEvent {}

class FetchRecentlyBookedDoctors extends GetRecentlyBookedDoctorsEvent{}
