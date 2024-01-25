part of 'get_member_by_id_bloc.dart';

@immutable
sealed class GetMemberByIdEvent {}

class FetchMemberById extends GetMemberByIdEvent {
  final String patientId;

  FetchMemberById({required this.patientId});
}
