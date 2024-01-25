import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetAppointments/get_upcoming_appointments_model.dart';
import 'package:mediezy_user/Repository/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'get_upcoming_appointment_event.dart';

part 'get_upcoming_appointment_state.dart';

class GetUpcomingAppointmentBloc
    extends Bloc<GetUpcomingAppointmentEvent, GetUpcomingAppointmentState> {
  late GetUpComingAppointmentsModel getUpComingAppointmentsModel;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  bool isLoaded = false;

  GetUpcomingAppointmentBloc() : super(GetUpcomingAppointmentInitial()) {
    on<GetUpcomingAppointmentEvent>((event, emit) async {
      // emit(GetUpComingAppointmentLoading());
      try {
        getUpComingAppointmentsModel =
            await getAppointmentApi.getUpComingApointments();
        isLoaded = true;
        emit(GetUpComingAppointmentLoaded(isLoaded: isLoaded));
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(GetUpComingAppointmentError());
      }
    });
  }
}
