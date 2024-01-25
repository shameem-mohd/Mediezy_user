part of 'delete_document_bloc.dart';

@immutable
sealed class DeleteDocumentEvent {}

class FetchDeletedDocument extends DeleteDocumentEvent {
  final String documentId;
  final String type;

  FetchDeletedDocument({required this.documentId, required this.type});
}
