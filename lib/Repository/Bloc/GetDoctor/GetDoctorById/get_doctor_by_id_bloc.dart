import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/Doctor/get_doctor_by_id_model.dart';
import 'package:mediezy_user/Repository/Api/GetDoctors/get_doctor_api.dart';
import 'package:meta/meta.dart';

part 'get_doctor_by_id_event.dart';
part 'get_doctor_by_id_state.dart';

class GetDoctorByIdBloc extends Bloc<GetDoctorByIdEvent, GetDoctorByIdState> {
  late GetDoctorByIdModel getDoctorByIdModel;
  GetDoctorsApi getDoctorsApi = GetDoctorsApi();
  GetDoctorByIdBloc() : super(GetDoctorByIdInitial()) {
    on<FetchDoctorById>((event, emit)async {
      emit(GetDoctorByIdLoading());
      try {
        getDoctorByIdModel = await GetDoctorsApi().getDoctorById(event.id);
        emit(GetDoctorByIdLoaded());
      } catch (error) {
         print(
              "<<<<<<GET DOCTORS BY ID ERROR>>>>>>" + error.toString());
          emit(GetDoctorByIdError());
        
      }
    });
  }
}
