import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetAllMembers/get_all_members_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'get_all_members_event.dart';
part 'get_all_members_state.dart';

class GetAllMembersBloc extends Bloc<GetAllMembersEvent, GetAllMembersState> {
  HealthRecordApi healthRecordApi = HealthRecordApi();
  late GetAllMembersModel getAllMembersModel;
  GetAllMembersBloc() : super(GetAllMembersInitial()) {
    on<FetchAllMembers>((event, emit) async {
      emit(GetAllMembersLoading());
      try {
        getAllMembersModel = await healthRecordApi.getAllMembers();
        emit(GetAllMembersLoaded());
      } catch (error) {
        print("<<<<<<<<<<GetAllAddedMembersError>>>>>>>>>>" + error.toString());
        emit(GetAllMembersError());
      }
    });
  }
}
