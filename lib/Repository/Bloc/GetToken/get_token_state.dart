part of 'get_token_bloc.dart';

@immutable
abstract class GetTokenState {}

class GetTokenInitial extends GetTokenState {}
class GetTokenLoading extends GetTokenState {}
class GetTokenLoaded extends GetTokenState {}
class GetTokenError extends GetTokenState {}
