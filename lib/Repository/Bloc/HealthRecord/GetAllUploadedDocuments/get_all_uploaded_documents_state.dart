part of 'get_all_uploaded_documents_bloc.dart';

@immutable
sealed class GetAllUploadedDocumentsState {}

final class GetAllUploadedDocumentsInitial extends GetAllUploadedDocumentsState {}


class GetAllUploadedDocumentsLoading extends GetAllUploadedDocumentsState{}
class GetAllUploadedDocumentsLoaded extends GetAllUploadedDocumentsState{}
class GetAllUploadedDocumentsError extends GetAllUploadedDocumentsState{}

