import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/Profile/get_user_model.dart';
import 'package:mediezy_user/Repository/Api/Profile/profile_api.dart';
import 'package:meta/meta.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  late GetUserModel getUserModel;
  ProfileApi profileApi = ProfileApi();
  GetUserBloc() : super(GetUserInitial()) {
    on<FetchUserDetails>((event, emit)async {
      emit(GetUserDetailsLoading());
       try {
        getUserModel = await profileApi.getUserDetails();
        emit(GetUserDetailsLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>><<<<<<<<<<<<<<>>>>>>>>>>>" + e.toString());
        emit(GetUserDetailsError());
      }
    });
  }
}
