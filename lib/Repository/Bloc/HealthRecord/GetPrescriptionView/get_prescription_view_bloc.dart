import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetPrescriptionView/get_prescription_view_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_prescription_view_event.dart';
part 'get_prescription_view_state.dart';

class GetPrescriptionViewBloc
    extends Bloc<GetPrescriptionViewEvent, GetPrescriptionViewState> {
        late GetPrescriptionViewModel getPrescriptionViewModel;
  HealthRecordApi healthRecordsApi = HealthRecordApi();
  GetPrescriptionViewBloc() : super(GetPrescriptionViewInitial()) {
    on<FetchGetPrescriptionView>((event, emit) async {
      emit(GetPrescriptionViewLoading());
      try {
        getPrescriptionViewModel = await healthRecordsApi.getPrescriptionView(
            patientId: event.patientId);
        emit(GetPrescriptionViewLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(GetPrescriptionViewError());
      }
    });
  }
}
