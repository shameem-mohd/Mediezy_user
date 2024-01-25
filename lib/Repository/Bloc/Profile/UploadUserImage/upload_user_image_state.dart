part of 'upload_user_image_bloc.dart';

@immutable
sealed class UploadUserImageState {}

final class UploadUserImageInitial extends UploadUserImageState {}


class UploadUserImageLoading extends UploadUserImageState{}
class UploadUserImageLoaded extends UploadUserImageState{}
class UploadUserImageError extends UploadUserImageState{}

