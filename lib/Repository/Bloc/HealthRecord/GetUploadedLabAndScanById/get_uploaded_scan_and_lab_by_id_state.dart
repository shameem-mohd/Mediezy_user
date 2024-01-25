part of 'get_uploaded_scan_and_lab_by_id_bloc.dart';

@immutable
sealed class GetUploadedScanAndLabByIdState {}

final class GetUploadedScanAndLabByIdInitial extends GetUploadedScanAndLabByIdState {}



class GetUploadedScanAndLabByIdLoading extends GetUploadedScanAndLabByIdState{}
class GetUploadedScanAndLabByIdLoaded extends GetUploadedScanAndLabByIdState{}
class GetUploadedScanAndLabByIdError extends GetUploadedScanAndLabByIdState{}

