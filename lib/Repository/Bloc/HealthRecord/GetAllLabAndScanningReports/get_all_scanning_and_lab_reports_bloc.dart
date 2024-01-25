import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetUploadedScanningAndLabReport/get_uploaded_scanning_and_lab_report_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_all_scanning_and_lab_reports_event.dart';
part 'get_all_scanning_and_lab_reports_state.dart';

class GetAllScanningAndLabReportsBloc extends Bloc<
    GetAllScanningAndLabReportsEvent, GetAllScanningAndLabReportsState> {
  HealthRecordApi healthRecordApi = HealthRecordApi();
  late GetUploadedScanningAndLabModel getUploadedScanningAndLabModel;
  GetAllScanningAndLabReportsBloc()
      : super(GetAllScanningAndLabReportsInitial()) {
    on<FetchUploadedScanningAndLabReports>((event, emit) async {
      emit(GetAllScanningAndLabReportsLoading());
      try {
        getUploadedScanningAndLabModel = await healthRecordApi
            .getAllUploadedScanningAndLabReports(patientId: event.patientId);
        emit(GetAllScanningAndLabReportsLoaded());
      } catch (error) {
        print("<<<<<<<<<<GetAllUploadedLabAndScanningReportsError>>>>>>>>>>" +
            error.toString());
        emit(GetAllScanningAndLabReportsError());
      }
    });
  }
}
