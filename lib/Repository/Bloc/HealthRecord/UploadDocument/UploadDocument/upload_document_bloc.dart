import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/UploadDocumentModel/upload_document_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/UploadDocumentApi.dart';
import 'package:meta/meta.dart';

part 'upload_document_event.dart';
part 'upload_document_state.dart';

class UploadDocumentBloc extends Bloc<UploadDocumentEvent, UploadDocumentState> {
  late UpLoadDocumentModel uploadDocumentModel;
  UploadDocumentApi uploadDocumentApi=UploadDocumentApi();
  UploadDocumentBloc() : super(UploadDocumentInitial()) {
    on<FetchUploadDocuments>((event, emit) async {
      emit(UploadDocumentLoading());
      try {
        uploadDocumentModel = await uploadDocumentApi.uploadDocument(document: event.document);
        emit(UploadDocumentLoaded());
      } catch (error) {
        print("<<<<<<<<<<GetAllAddedMembersError>>>>>>>>>>" + error.toString());
        emit(UploadDocumentError());
      }
    });
  }
}
