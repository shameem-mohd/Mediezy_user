part of 'get_health_categories_bloc.dart';

@immutable
sealed class GetHealthCategoriesState {}

final class GetHealthCategoriesInitial extends GetHealthCategoriesState {}


class GetHealthCategoriesLoading extends GetHealthCategoriesState{}
class GetHealthCategoriesLoaded extends GetHealthCategoriesState{}
class GetHealthCategoriesError extends GetHealthCategoriesState{}
