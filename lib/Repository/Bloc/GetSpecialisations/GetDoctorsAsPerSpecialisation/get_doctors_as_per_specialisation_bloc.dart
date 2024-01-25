import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetSpecialisations/get_doctors_as_per_specialisation_model.dart';
import 'package:mediezy_user/Repository/Api/GetSpecialisations/get_specialisations_api.dart';
import 'package:meta/meta.dart';

part 'get_doctors_as_per_specialisation_event.dart';
part 'get_doctors_as_per_specialisation_state.dart';

class GetDoctorsAsPerSpecialisationBloc extends Bloc<
    GetDoctorsAsPerSpecialisationEvent, GetDoctorsAsPerSpecialisationState> {
  late GetDoctersAsPerSpecialisationModel getDoctersAsPerSpecialisationModel;
  GetSpecialisationsApi getSpecialisationsApi = GetSpecialisationsApi();
  GetDoctorsAsPerSpecialisationBloc()
      : super(GetDoctorsAsPerSpecialisationInitial()) {
    on<FetchDocterAsperSpecialisaton>((event, emit) async {
      emit(GetDoctorsAsperSpecialisationLoading());
      try {
        getDoctersAsPerSpecialisationModel = await getSpecialisationsApi
            .getDoctorsAsPerSpecialisation(id: event.id);
        emit(GetDoctorsAsperSpecialisationLoaded());
      } catch (error) {
        print("<<<<<<<<<<Get Doctor As Per Specialisation Error>>>>>>>>>>" +
            error.toString());
        emit(GetDoctorsAsperSpecialisationError());
      }
    });
  }
}
