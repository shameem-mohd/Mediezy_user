import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetFavourites/get_favourites_model.dart';
import 'package:mediezy_user/Repository/Api/Favourites/favourites_api.dart';
import 'package:meta/meta.dart';

part 'get_favourites_event.dart';
part 'get_favourites_state.dart';

class GetFavouritesBloc extends Bloc<GetFavouritesEvent, GetFavouritesState> {
  late GetFavouritesModel getFavouritesModel;
  FavouritesApi favouriteApi = FavouritesApi();
  GetFavouritesBloc() : super(GetFavouritesInitial()) {
    on<FetchAllFavourites>((event, emit) async {
      emit(GetAllFavouritesLoading());
      try {
        getFavouritesModel = await favouriteApi.getAllFavourites();
        emit(GetAllFavouritesLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit((GetAllFavouritesError()));
      }
    });
  }
}
