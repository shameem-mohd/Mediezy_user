import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetRecentlyBookedDoctor/get_recently_booked_doctor_model.dart';
import 'package:mediezy_user/Repository/Api/GetRecentlyBookedDoctors/get_recently_booked_dcotors_api.dart';
import 'package:meta/meta.dart';

part 'get_recently_booked_doctors_event.dart';
part 'get_recently_booked_doctors_state.dart';

class GetRecentlyBookedDoctorsBloc
    extends Bloc<GetRecentlyBookedDoctorsEvent, GetRecentlyBookedDoctorsState> {
  late GetRecentlyBookedDoctorModel getRecentlyBookedDoctorModel;
  GetRecentlyBookedDoctorApi getRecentlyBookedDoctorApi =
      GetRecentlyBookedDoctorApi();
  GetRecentlyBookedDoctorsBloc() : super(GetRecentlyBookedDoctorsInitial()) {
    on<FetchRecentlyBookedDoctors>((event, emit) async {
      emit(GetRecentlyBookedDoctorLoading());
      try {
        getRecentlyBookedDoctorModel =
            await getRecentlyBookedDoctorApi.getAllRecentlyBookedDoctor();
        emit(GetRecentlyBookedDoctorLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(GetRecentlyBookedDoctorError());
      }
    });
  }
}
