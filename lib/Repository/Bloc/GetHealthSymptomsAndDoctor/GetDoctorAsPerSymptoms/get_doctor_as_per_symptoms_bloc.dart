import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetSymptomAndDoctor/get_doctor_as_per_health_symptoms_model.dart';
import 'package:mediezy_user/Repository/Api/GetHealthSymptoms/get_health_symptoms_api.dart';
import 'package:meta/meta.dart';

part 'get_doctor_as_per_symptoms_event.dart';
part 'get_doctor_as_per_symptoms_state.dart';

class GetDoctorAsPerSymptomsBloc
    extends Bloc<GetDoctorAsPerSymptomsEvent, GetDoctorAsPerSymptomsState> {
  late GetDoctorAsPerHealthSymptomsModel getDoctorAsPerHealthSymptomsModel;
  GetHealthSympyomsApi getHealthSympyomsApi = GetHealthSympyomsApi();
  GetDoctorAsPerSymptomsBloc() : super(GetDoctorAsPerSymptomsInitial()) {
    on<FetchDoctorAsPerHealthSymptoms>((event, emit) async {
      emit(GetDoctorsAsperHealthSymptomsLoading());
      try {
        getDoctorAsPerHealthSymptomsModel = await getHealthSympyomsApi
            .getDoctorsAsPerHealthSymptoms(id: event.id);
        emit(GetDoctorsAsperHealthSymptomsLoaded());
      } catch (error) {
        print("<<<<<<<<<<Get Doctor As Per Health Symptoms Error>>>>>>>>>>" +
            error.toString());
        emit(GetDoctorsAsperHealthSymptomsError());
      }
    });
  }
}
