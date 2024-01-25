import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_user/Model/BookAppointment/book_appointment_model.dart';
import 'package:mediezy_user/Repository/Api/BookAppointment/book_appointment_api.dart';

part 'book_appointment_event.dart';
part 'book_appointment_state.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  late BookAppointmentModel bookAppointmentModel;
  BookAppointmentApi bookAppointmentApi = BookAppointmentApi();
  BookAppointmentBloc() : super(BookAppointmentInitial()) {
    on<PassBookAppointMentEvent>((event, emit) async {
      emit(BookAppointmentLoading());
      try {
        bookAppointmentModel = await bookAppointmentApi.bookAppointment(
            patientName: event.patientName,
            date: event.date,
            regularmedicine: event.regularmedicine,
            whenitcomes: event.whenitcomes,
            whenitstart: event.whenitstart,
            tokenTime: event.tokenTime,
            tokenNumber: event.tokenNumber,
            gender: event.gender,
            age: event.age,
            mobileNo: event.mobileNo,
            appoinmentfor1: event.appoinmentfor1,
            appoinmentfor2: event.appoinmentfor2,
            doctorId: event.doctorId,
            clinicId: event.clinicId,
            bookingType: event.bookingType,
            endingTime: event.endingTime
            );
        emit(BookAppointmentLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>><<<<<<<<<<<<<<>>>>>>>>>>>" + e.toString());
        emit(BookAppointmentError());
      }
    });
  }
}