import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/HealthCategories/get_doctors_by_health_categories_model.dart';
import 'package:mediezy_user/Repository/Api/HealthCategories/health_categories_api.dart';
import 'package:meta/meta.dart';

part 'get_doctors_by_health_category_event.dart';
part 'get_doctors_by_health_category_state.dart';

class GetDoctorsByHealthCategoryBloc extends Bloc<
    GetDoctorsByHealthCategoryEvent, GetDoctorsByHealthCategoryState> {
  late GetDoctorsByHealthCategoriesModel getDoctorsByHealthCategoriesModel;
  HealthCategoriesApi healthCategoriesApi = HealthCategoriesApi();
  GetDoctorsByHealthCategoryBloc()
      : super(GetDoctorsByHealthCategoryInitial()) {
    on<FetchDoctorByHealthCategory>((event, emit) async {
      emit(GetDoctorsByHealthCategoryLoading());
      try {
        getDoctorsByHealthCategoriesModel =
            await healthCategoriesApi.getDoctorsByHealthCategories(
                healthCategoryId: event.healthCategoryId);
                emit(GetDoctorsByHealthCategoryLoaded());
      } catch (error) {
        print("<<<<<<GET DOCTORS BY HEALTH CATEGORY ERROR>>>>>>" +
            error.toString());
        emit(GetDoctorsByHealthCategoryError());
      }
    });
  }
}
