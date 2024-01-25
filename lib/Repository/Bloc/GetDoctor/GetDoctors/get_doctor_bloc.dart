import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/Doctor/doctor_model.dart';
import 'package:mediezy_user/Repository/Api/GetDoctors/get_doctor_api.dart';
import 'package:meta/meta.dart';

part 'get_doctor_event.dart';
part 'get_doctor_state.dart';

class GetDoctorBloc extends Bloc<GetDoctorEvent, GetDoctorState> {
  late DoctorModel doctorModel;
  GetDoctorsApi getDoctorsApi = GetDoctorsApi();

  GetDoctorBloc() : super(GetDoctorInitial()) {
    on<FetchGetDoctor>(
      (event, emit) async {
        emit(GetDoctorLoading());
        try {
          doctorModel = await getDoctorsApi.getDoctor();
          emit(GetDoctorLoaded());
        } catch (error) {
          print(
              "<<<<<<GET ALL DOCTORS ERROR>>>>>>" + error.toString());
          emit(GetDoctorError());
        }
      },
    );
  }
}
