import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetAppointments/get_completed_appointments_model.dart';
import 'package:mediezy_user/Repository/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';
part 'get_completed_appointments_event.dart';
part 'get_completed_appointments_state.dart';

class GetCompletedAppointmentsBloc
    extends Bloc<GetCompletedAppointmentsEvent, GetCompletedAppointmentsState> {
  late GetCompletedAppointmentsModel getCompletedAppointmentsModel;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  GetCompletedAppointmentsBloc() : super(GetCompletedAppointmentsInitial()) {
    on<GetCompletedAppointmentsEvent>((event, emit) async {
      emit(GetCompletedAppointmentLoading());
      try {
        getCompletedAppointmentsModel =
            await getAppointmentApi.getCompletedApointments();
        emit(GetCompletedAppointmentLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(GetCompletedAppointmentError());
      }
    });
  }
}
