import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetUploadedLabAndScanById/get_uploaded_lob_and_scan_by_id_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_uploaded_scan_and_lab_by_id_event.dart';
part 'get_uploaded_scan_and_lab_by_id_state.dart';

class GetUploadedScanAndLabByIdBloc extends Bloc<GetUploadedScanAndLabByIdEvent, GetUploadedScanAndLabByIdState> {
  HealthRecordApi healthRecordApi = HealthRecordApi();
  late GetUploadedScanAndLabByIdModel getUploadedScanAndLabByIdModel;
  GetUploadedScanAndLabByIdBloc() : super(GetUploadedScanAndLabByIdInitial()) {
    on<FetchUploadedScanAndLabById>((event, emit) async{
      emit(GetUploadedScanAndLabByIdLoading());
      try {
        getUploadedScanAndLabByIdModel = await healthRecordApi.getUploadedLabAndScanAsPerId(documentId: event.documentId);
        emit(GetUploadedScanAndLabByIdLoaded());
      } catch (error) {
          print("<<<<<<<<<<GetUploadedLabAndScanAsPerIdError>>>>>>>>>>" + error.toString());
        emit(GetUploadedScanAndLabByIdError());
      }
    
    });
  }
}
