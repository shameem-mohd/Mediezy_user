import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetAllergy/get_allery_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_allergy_event.dart';
part 'get_allergy_state.dart';

class GetAllergyBloc extends Bloc<GetAllergyEvent, GetAllergyState> {
  HealthRecordApi healthRecordApi = HealthRecordApi();
  late GetAllergyModel getAllergyModel;
  GetAllergyBloc() : super(GetAllergyInitial()) {
    on<FetchAllergy>((event, emit) async {
      emit(GetAllergyLoading());
      try {
        getAllergyModel = await healthRecordApi.getAllery();
        emit(GetAllergyLoaded());
      } catch (error) {
        print("<<<<<<<<<<<<<get allergy error>>>>>>");
        emit(GetAllergyError());
      }
    });
  }
}
