import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetTokens/GetTokenModel.dart';
import 'package:mediezy_user/Repository/Api/GetToken/get_token_api.dart';
import 'package:meta/meta.dart';

part 'get_token_event.dart';
part 'get_token_state.dart';

class GetTokenBloc extends Bloc<GetTokenEvent, GetTokenState> {
  late GetTokenModel getTokenModel;
  GetTokenApi getTokenApi = GetTokenApi();
  GetTokenBloc() : super(GetTokenInitial()) {
    on<FetchToken>((event, emit) async {
      emit(GetTokenLoading());
      try {
        getTokenModel = await getTokenApi.getTokens(
            doctorId: event.doctorId, hospitalId: event.hospitalId, date: event.date);
        emit(GetTokenLoaded());
      } catch (error) {
        print("<<<<<<<<<<GetAllAddedMembersError>>>>>>>>>>" + error.toString());
        emit(GetTokenError());
      }
    });
  }
}
