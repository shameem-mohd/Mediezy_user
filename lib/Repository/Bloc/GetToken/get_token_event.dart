part of 'get_token_bloc.dart';

@immutable
abstract class GetTokenEvent {}


class FetchToken extends GetTokenEvent{
  final String doctorId;
  final String hospitalId;
  final String date;

  FetchToken({
    required this.doctorId,
    required this.hospitalId,
    required this.date,
});
}