part of 'upload_document_bloc.dart';

@immutable
abstract class UploadDocumentEvent {}



class FetchUploadDocuments extends UploadDocumentEvent {
  final File document;
  FetchUploadDocuments({
    required this.document
  }
      );
}