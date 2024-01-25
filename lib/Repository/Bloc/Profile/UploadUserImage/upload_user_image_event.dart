part of 'upload_user_image_bloc.dart';

@immutable
sealed class UploadUserImageEvent {}

class FetchUploadUserImage extends UploadUserImageEvent {
  final File userImage;

  FetchUploadUserImage({required this.userImage});
}
