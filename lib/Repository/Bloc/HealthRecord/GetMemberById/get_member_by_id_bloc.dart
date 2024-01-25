import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetMemberAsPerId/get_member_as_per_id_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_member_by_id_event.dart';
part 'get_member_by_id_state.dart';

class GetMemberByIdBloc extends Bloc<GetMemberByIdEvent, GetMemberByIdState> {
  HealthRecordApi healthRecordApi = HealthRecordApi();
  late GetMemberAsPerIdModel getMemberAsPerIdModel;
  GetMemberByIdBloc() : super(GetMemberByIdInitial()) {
    on<FetchMemberById>((event, emit)async {
      emit(GetMemberByIdLoading());
      try {
        getMemberAsPerIdModel = await healthRecordApi.getMemberAsPerId(patientId: event.patientId);
        emit(GetMemberByIdLoaded());
      } catch (error) {
         print("<<<<<<<<<<GetMemberAsPerIdError>>>>>>>>>>" + error.toString());
        emit(GetMemberByIdError());
      }

    });
  }
}
