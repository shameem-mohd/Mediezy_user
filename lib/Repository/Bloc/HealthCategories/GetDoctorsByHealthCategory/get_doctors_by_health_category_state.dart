part of 'get_doctors_by_health_category_bloc.dart';

@immutable
sealed class GetDoctorsByHealthCategoryState {}

final class GetDoctorsByHealthCategoryInitial extends GetDoctorsByHealthCategoryState {}

class GetDoctorsByHealthCategoryLoading extends GetDoctorsByHealthCategoryState{}
class GetDoctorsByHealthCategoryLoaded extends GetDoctorsByHealthCategoryState{}
class GetDoctorsByHealthCategoryError extends GetDoctorsByHealthCategoryState{}

