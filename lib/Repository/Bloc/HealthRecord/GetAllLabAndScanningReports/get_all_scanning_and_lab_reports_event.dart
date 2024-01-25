part of 'get_all_scanning_and_lab_reports_bloc.dart';

@immutable
sealed class GetAllScanningAndLabReportsEvent {}

class FetchUploadedScanningAndLabReports
    extends GetAllScanningAndLabReportsEvent {
  final String patientId;

  FetchUploadedScanningAndLabReports({required this.patientId});
}
