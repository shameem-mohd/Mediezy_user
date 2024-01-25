part of 'search_doctor_bloc.dart';

@immutable
sealed class SearchDoctorEvent {}

class FetchSeachedDoctor extends SearchDoctorEvent {
  final String searchQuery;

  FetchSeachedDoctor({required this.searchQuery});
}
