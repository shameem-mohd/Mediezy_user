part of 'get_allergy_bloc.dart';

@immutable
sealed class GetAllergyState {}

final class GetAllergyInitial extends GetAllergyState {}


class GetAllergyLoading extends GetAllergyState{}

class GetAllergyLoaded extends GetAllergyState{}

class GetAllergyError extends GetAllergyState{}
