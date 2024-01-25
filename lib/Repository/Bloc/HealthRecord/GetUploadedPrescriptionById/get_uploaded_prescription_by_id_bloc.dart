import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetUploadedPrescriptionById/get_uploaded_prescription_by_id_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_uploaded_prescription_by_id_event.dart';
part 'get_uploaded_prescription_by_id_state.dart';

class GetUploadedPrescriptionByIdBloc extends Bloc<
    GetUploadedPrescriptionByIdEvent, GetUploadedPrescriptionByIdState> {
  HealthRecordApi healthRecordApi = HealthRecordApi();
  late GetUploadedPrescriptionByIdModel getUploadedPrescriptionByIdModel;
  GetUploadedPrescriptionByIdBloc()
      : super(GetUploadedPrescriptionByIdInitial()) {
    on<FetchUploadedPrescriptionById>((event, emit)async {
      emit(GetUploadedPrescriptionByIdLoading());
      try {
        getUploadedPrescriptionByIdModel = await healthRecordApi.getUploadedPrescriptionAsPerId(documentId: event.documentId);
        emit(GetUploadedPrescriptionByIdLoaded());
      } catch (error) {
         print("<<<<<<<<<<GetUploadedPrescriptionAsPerIdError>>>>>>>>>>" + error.toString());
        emit(GetUploadedPrescriptionByIdError());
      }

    });
  }
}
