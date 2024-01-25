part of 'get_all_specialisations_bloc.dart';

@immutable
sealed class GetAllSpecialisationsEvent {}

class FetchAllSpecialisations extends GetAllSpecialisationsEvent{}
