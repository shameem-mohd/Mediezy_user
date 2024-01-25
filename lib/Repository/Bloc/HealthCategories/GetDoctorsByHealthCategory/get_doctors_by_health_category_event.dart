part of 'get_doctors_by_health_category_bloc.dart';

@immutable
sealed class GetDoctorsByHealthCategoryEvent {}

class FetchDoctorByHealthCategory extends GetDoctorsByHealthCategoryEvent {
  final String healthCategoryId;

  FetchDoctorByHealthCategory({required this.healthCategoryId});
}
