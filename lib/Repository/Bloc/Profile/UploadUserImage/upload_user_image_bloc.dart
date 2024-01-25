import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Repository/Api/Profile/profile_api.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';
part 'upload_user_image_event.dart';
part 'upload_user_image_state.dart';

class UploadUserImageBloc
    extends Bloc<UploadUserImageEvent, UploadUserImageState> {
  ProfileApi profileApi = ProfileApi();
  late String updoadedSuccessfully;
  UploadUserImageBloc() : super(UploadUserImageInitial()) {
    on<FetchUploadUserImage>((event, emit) async {
      emit(UploadUserImageLoading());
      try {
        updoadedSuccessfully =
            await profileApi.uploadUserImage(userImage: event.userImage);
        emit(UploadUserImageLoaded());
        Map<String, dynamic> data = jsonDecode(updoadedSuccessfully);
        GeneralServices.instance.showToastMessage(data['response']);
      } catch (error) {
        print("<<<<<<<<<<UploadUserImageError>>>>>>>>>>" + error.toString());
        emit(UploadUserImageError());
      }
    });
  }
}
