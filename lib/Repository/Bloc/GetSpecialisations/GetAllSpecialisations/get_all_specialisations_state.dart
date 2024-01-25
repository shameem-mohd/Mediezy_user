part of 'get_all_specialisations_bloc.dart';

@immutable
sealed class GetAllSpecialisationsState {}

final class GetAllSpecialisationsInitial extends GetAllSpecialisationsState {}

class GetAllSpecialisationsLoading extends GetAllSpecialisationsState {}

class GetAllSpecialisationsLoaded extends GetAllSpecialisationsState {}

class GetAllSpecialisationsError extends GetAllSpecialisationsState {}
