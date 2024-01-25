part of 'get_health_categories_bloc.dart';

@immutable
sealed class GetHealthCategoriesEvent {}

class FetchHealthCategories extends GetHealthCategoriesEvent{}
