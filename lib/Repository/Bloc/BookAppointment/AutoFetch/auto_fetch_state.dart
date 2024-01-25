part of 'auto_fetch_bloc.dart';

@immutable
sealed class AutoFetchState {}

final class AutoFetchInitial extends AutoFetchState {}

class AutoFetchLoading extends AutoFetchState {}

class AutoFetchLoaded extends AutoFetchState {}

class AutoFetchError extends AutoFetchState {}
