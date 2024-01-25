import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetUploadedPrescriptions/get_uploaded_prescription_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_all_prescriptions_event.dart';
part 'get_all_prescriptions_state.dart';

class GetAllPrescriptionsBloc
    extends Bloc<GetAllPrescriptionsEvent, GetAllPrescriptionsState> {
  HealthRecordApi healthRecordApi = HealthRecordApi();
  late GetUploadedPrescriptionModel getUploadedPrescriptionModel;
  GetAllPrescriptionsBloc() : super(GetAllPrescriptionsInitial()) {
    on<FetchUploadedPrescriptions>((event, emit) async {
      emit(GetAllPrescriptionsLoading());
      try {
        getUploadedPrescriptionModel = await healthRecordApi
            .getAllUploadedPrescriptions(patientId: event.patientId);
        emit(GetAllPrescriptionsLoaded());
      } catch (error) {
        print("<<<<<<<<<<GetAllUploadedPrescriptionsError>>>>>>>>>>" +
            error.toString());
        emit(GetAllPrescriptionsError());
      }
    });
  }
}
