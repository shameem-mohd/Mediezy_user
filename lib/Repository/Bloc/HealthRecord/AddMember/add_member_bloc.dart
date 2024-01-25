import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';
part 'add_member_event.dart';
part 'add_member_state.dart';

class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberState> {
  late String updatedSuccessfullyMessage;
  HealthRecordApi healthRecordApi = HealthRecordApi();
  AddMemberBloc() : super(AddMemberInitial()) {
    on<FetchAddMember>((event, emit) async {
      emit(AddMemberLoadingState());
      try {
        updatedSuccessfullyMessage = await healthRecordApi.addMember(
            age: event.age,
            fullName: event.fullName,
            gender: event.gender,
            relation: event.relation,
            allergyId: event.allergyId,
            allergyName: event.allergyName,
            mobileNumber: event.mobileNumber,
            regularMedicine: event.regularMedicine,
            surgeryName: event.surgeyName,
            treatmentTaken: event.treatmentTaken,
            illness: event.illness,
            medicineTaken: event.medicineTaken
            );
        emit(AddMemberLoadedState());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfullyMessage);
        GeneralServices.instance.showToastMessage(data['response']);
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(AddMemberErrorState());
      }
    });
  }
}
