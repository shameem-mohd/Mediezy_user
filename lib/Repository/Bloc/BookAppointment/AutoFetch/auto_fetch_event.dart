part of 'auto_fetch_bloc.dart';

@immutable
sealed class AutoFetchEvent {}

class FetchAutoFetch extends AutoFetchEvent {
  final String section;
  final String patientId;

  FetchAutoFetch({required this.section, required this.patientId});
}
