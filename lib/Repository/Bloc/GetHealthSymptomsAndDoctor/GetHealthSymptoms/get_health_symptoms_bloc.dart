import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetSymptomAndDoctor/get_health_symptoms_model.dart';
import 'package:mediezy_user/Repository/Api/GetHealthSymptoms/get_health_symptoms_api.dart';
import 'package:meta/meta.dart';

part 'get_health_symptoms_event.dart';
part 'get_health_symptoms_state.dart';

class GetHealthSymptomsBloc extends Bloc<GetHealthSymptomsEvent, GetHealthSymptomsState> {
  late GetHealthSymptomsModel getHealthSymptomsModel;
  GetHealthSympyomsApi getHealthSympyomsApi = GetHealthSympyomsApi();
  GetHealthSymptomsBloc() : super(GetHealthSymptomsInitial()) {
    on<FetchAllHealthSymptoms>((event, emit)async {
      emit(GetHealthSymptomsLoading());
      try {
         getHealthSymptomsModel =
            await getHealthSympyomsApi.getAllHealthSymptoms();
        emit(GetHealthSymptomsLoaded());
      } catch (error) {
        print("<<<<<<<<<<Get Health Symptoms Error>>>>>>>>>>" + error.toString());
        emit(GetHealthSymptomsError());
        
      }
     
    });
  }
}
