part of 'upload_document_lab_and_scan_final_bloc.dart';

@immutable
abstract class UploadDocumentFinalState {}

class UploadDocumentFinalInitial extends UploadDocumentFinalState {}
class UploadDocumentFinalLoading extends UploadDocumentFinalState {}
class UploadDocumentFinalLoaded extends UploadDocumentFinalState {}
class UploadDocumentFinalError extends UploadDocumentFinalState {}
