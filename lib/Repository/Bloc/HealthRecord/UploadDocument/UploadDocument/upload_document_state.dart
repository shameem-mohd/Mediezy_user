part of 'upload_document_bloc.dart';

@immutable
abstract class UploadDocumentState {}

final class UploadDocumentInitial extends UploadDocumentState {}
final class UploadDocumentLoading extends UploadDocumentState {}
final class UploadDocumentLoaded extends UploadDocumentState {}
final class UploadDocumentError extends UploadDocumentState {}
