import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/AutoFetch/auto_fetch_model.dart';
import 'package:mediezy_user/Repository/Api/BookAppointment/book_appointment_api.dart';
import 'package:meta/meta.dart';

part 'auto_fetch_event.dart';
part 'auto_fetch_state.dart';

class AutoFetchBloc extends Bloc<AutoFetchEvent, AutoFetchState> {
  late AutoFetchModel autoFetchModel;
  BookAppointmentApi bookAppointmentApi = BookAppointmentApi();
  AutoFetchBloc() : super(AutoFetchInitial()) {
    on<FetchAutoFetch>((event, emit) async {
      emit(AutoFetchLoading());
      try {
        autoFetchModel = await bookAppointmentApi.autoFetchDetails(
            section: event.section, patientId: event.patientId);
        emit(AutoFetchLoaded());
      } catch (error) {
        print("<<<<<<< auth fetch details error $error>>>>>>");
        emit(AutoFetchError());
      }
    });
  }
}
