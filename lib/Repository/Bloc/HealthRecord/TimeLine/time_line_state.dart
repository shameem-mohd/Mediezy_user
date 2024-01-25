part of 'time_line_bloc.dart';

@immutable
sealed class TimeLineState {}

final class TimeLineInitial extends TimeLineState {}

class TimeLineLoading extends TimeLineState {}

class TimeLineLoaded extends TimeLineState {}

class TimeLineError extends TimeLineState {}
