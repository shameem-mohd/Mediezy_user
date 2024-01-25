import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Repository/Api/Favourites/favourites_api.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'add_favourites_event.dart';
part 'add_favourites_state.dart';

class AddFavouritesBloc extends Bloc<AddFavouritesEvent, AddFavouritesState> {
  late String updatedSuccessfullyMessage;
  FavouritesApi favouritesApi = FavouritesApi();

  AddFavouritesBloc() : super(AddFavouritesInitial()) {
    on<AddFavourites>((event, emit) async {
      emit(AddFavouritesLoading());
      try {
        updatedSuccessfullyMessage =
            await favouritesApi.addFavourites(doctorId: event.doctorId);
        emit(AddFavouritesLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfullyMessage);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (error) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + error.toString());
        emit(AddFavouritesError());
      }
    });
  }
}
