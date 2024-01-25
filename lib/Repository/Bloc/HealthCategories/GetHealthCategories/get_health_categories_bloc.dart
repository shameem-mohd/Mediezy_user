import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/HealthCategories/get_health_categories_model.dart';
import 'package:mediezy_user/Repository/Api/HealthCategories/health_categories_api.dart';
import 'package:meta/meta.dart';

part 'get_health_categories_event.dart';
part 'get_health_categories_state.dart';

class GetHealthCategoriesBloc
    extends Bloc<GetHealthCategoriesEvent, GetHealthCategoriesState> {
  late GetHealthCategoriesModel getHealthCategoriesModel;
  HealthCategoriesApi healthCategoriesApi = HealthCategoriesApi();
  GetHealthCategoriesBloc() : super(GetHealthCategoriesInitial()) {
    on<FetchHealthCategories>((event, emit) async {
      emit(GetHealthCategoriesLoading());
      try {
        getHealthCategoriesModel =
            await healthCategoriesApi.getHealthCategories();
        emit(GetHealthCategoriesLoaded());
      } catch (error) {
        print("<<<<<<GET HEALTH CATEGORIES ERROR>>>>>>" + error.toString());
        emit(GetHealthCategoriesError());
      }
    });
  }
}
