import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';
part 'delete_member_event.dart';
part 'delete_member_state.dart';

class DeleteMemberBloc extends Bloc<DeleteMemberEvent, DeleteMemberState> {
  late String updatedSuccessfullyMessage;
  HealthRecordApi healthRecordApi = HealthRecordApi();
  DeleteMemberBloc() : super(DeleteMemberInitial()) {
    on<FetchDeleteMember>((event, emit) async {
      emit(DeleteMemberLoading());
      try {
        updatedSuccessfullyMessage =
            await healthRecordApi.deleteMember(patientId: event.patientId);
        emit(DeleteMemberLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfullyMessage);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(DeleteMemberError());
      }
    });
  }
}
