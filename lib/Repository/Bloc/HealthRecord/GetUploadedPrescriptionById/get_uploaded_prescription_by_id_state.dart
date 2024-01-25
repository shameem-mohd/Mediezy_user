part of 'get_uploaded_prescription_by_id_bloc.dart';

@immutable
sealed class GetUploadedPrescriptionByIdState {}

final class GetUploadedPrescriptionByIdInitial extends GetUploadedPrescriptionByIdState {}


class GetUploadedPrescriptionByIdLoading extends GetUploadedPrescriptionByIdState{}
class GetUploadedPrescriptionByIdLoaded extends GetUploadedPrescriptionByIdState{}
class GetUploadedPrescriptionByIdError extends GetUploadedPrescriptionByIdState{}

