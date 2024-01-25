import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/Search/search_doctor_model.dart';
import 'package:mediezy_user/Repository/Api/Search/search_doctor_api.dart';
import 'package:meta/meta.dart';

part 'search_doctor_event.dart';
part 'search_doctor_state.dart';

class SearchDoctorBloc extends Bloc<SearchDoctorEvent, SearchDoctorState> {
  late SearchDoctorModel searchDoctorModel;
  SearchApi searchApi = SearchApi();
  SearchDoctorBloc() : super(SearchDoctorInitial()) {
    on<FetchSeachedDoctor>((event, emit) async {
      emit(SearchDoctorLoading());
      try {
        searchDoctorModel =
            await searchApi.getSearchDoctors(searchQuery: event.searchQuery);
        emit(SearchDoctorLoaded());
      } catch (error) {
        print("<<<<<<GET SEARCH DOCTORS ERROR>>>>>>" + error.toString());
        emit(SearchDoctorError());
      }
    });
  }
}
