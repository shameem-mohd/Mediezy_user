import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetAllUploadedDocuments/get_all_uploaded_documet_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_all_uploaded_documents_event.dart';
part 'get_all_uploaded_documents_state.dart';

class GetAllUploadedDocumentsBloc
    extends Bloc<GetAllUploadedDocumentsEvent, GetAllUploadedDocumentsState> {
  HealthRecordApi healthRecordApi = HealthRecordApi();
  late GetAllUploadedDocumentModel getAllUploadedDocumentModel;
  GetAllUploadedDocumentsBloc() : super(GetAllUploadedDocumentsInitial()) {
    on<FetchAllUploadedDocuments>((event, emit) async {
      emit(GetAllUploadedDocumentsLoading());
      try {
        getAllUploadedDocumentModel = await healthRecordApi
            .getAllUploadedDocuments(patientId: event.patientId);
        emit(GetAllUploadedDocumentsLoaded());
      } catch (error) {
        print("<<<<<<<<<<GetAllUploadedDocumentsError>>>>>>>>>>" +
            error.toString());
        emit(GetAllUploadedDocumentsError());
      }
    });
  }
}
