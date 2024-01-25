import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'delete_document_event.dart';
part 'delete_document_state.dart';

class DeleteDocumentBloc
    extends Bloc<DeleteDocumentEvent, DeleteDocumentState> {
  late String updatedSuccessfullyMessage;
  HealthRecordApi healthRecordApi = HealthRecordApi();
  DeleteDocumentBloc() : super(DeleteDocumentInitial()) {
    on<FetchDeletedDocument>((event, emit) async {
      emit(DeleteDocumentLoading());
      try {
        updatedSuccessfullyMessage =
            await healthRecordApi.deleteUploadedDocument(
                documentId: event.documentId, type: event.type);
        emit(DeleteDocumentLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfullyMessage);
        GeneralServices.instance.showToastMessage(data['response']);
      } catch (error) {
        print("<<<<<<<Delete Document error>>>$error");
        emit(DeleteDocumentError());
      }
    });
  }
}
