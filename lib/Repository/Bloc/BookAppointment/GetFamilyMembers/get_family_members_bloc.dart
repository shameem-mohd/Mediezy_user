import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetFamilyMembers/get_family_members_model.dart';
import 'package:mediezy_user/Repository/Api/BookAppointment/book_appointment_api.dart';
import 'package:meta/meta.dart';
part 'get_family_members_event.dart';
part 'get_family_members_state.dart';

class GetFamilyMembersBloc
    extends Bloc<GetFamilyMembersEvent, GetFamilyMembersState> {
  BookAppointmentApi bookAppointmentApi = BookAppointmentApi();
  late GetFamilyMembersModel getFamilyMembersModel;
  GetFamilyMembersBloc() : super(GetFamilyMembersInitial()) {
    on<FetchFamilyMember>((event, emit) async {
      emit(GetFamilyMembersLoading());
      try {
        getFamilyMembersModel =await bookAppointmentApi.getFamilyMembers();
        emit(GetFamilyMembersLoaded ());
      } catch (error) {
        print("<<<<<<<Get Family members error $error >>>>>>>>");
        emit(GetFamilyMembersError());
      }
    });
  }
}
