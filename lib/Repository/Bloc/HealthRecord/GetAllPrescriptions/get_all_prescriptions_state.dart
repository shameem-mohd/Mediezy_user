part of 'get_all_prescriptions_bloc.dart';

@immutable
sealed class GetAllPrescriptionsState {}

final class GetAllPrescriptionsInitial extends GetAllPrescriptionsState {}

class GetAllPrescriptionsLoading extends GetAllPrescriptionsState{}
class GetAllPrescriptionsLoaded extends GetAllPrescriptionsState{}
class GetAllPrescriptionsError extends GetAllPrescriptionsState{}
