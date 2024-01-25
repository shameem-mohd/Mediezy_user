import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_user/Model/GetSpecialisations/get_specialisations_model.dart';
import 'package:mediezy_user/Repository/Api/GetSpecialisations/get_specialisations_api.dart';
part 'get_all_specialisations_event.dart';
part 'get_all_specialisations_state.dart';

class GetAllSpecialisationsBloc
    extends Bloc<GetAllSpecialisationsEvent, GetAllSpecialisationsState> {
  late GetSpecialisationsModel getSpecialisationsModel;
  GetSpecialisationsApi getSpecialisationsApi = GetSpecialisationsApi();
  GetAllSpecialisationsBloc() : super(GetAllSpecialisationsInitial()) {
    on<FetchAllSpecialisations>((event, emit) async {
      emit(GetAllSpecialisationsLoading());
      try {
        getSpecialisationsModel =
            await getSpecialisationsApi.getAllSpecialisations();
        emit(GetAllSpecialisationsLoaded());
      } catch (error) {
        print("<<<<<<<<<<Get Specialisation Error>>>>>>>>>>" + error.toString());
        emit(GetAllSpecialisationsError());
      }
    });
  }
}
