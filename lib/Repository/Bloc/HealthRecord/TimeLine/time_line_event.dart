part of 'time_line_bloc.dart';

@immutable
sealed class TimeLineEvent {}

class FetchTimeLine extends TimeLineEvent {
  final String patientId;
  FetchTimeLine({
    required this.patientId,
  });
}
