part of 'delete_document_bloc.dart';

@immutable
sealed class DeleteDocumentState {}

final class DeleteDocumentInitial extends DeleteDocumentState {}


class DeleteDocumentLoading extends DeleteDocumentState{}
class DeleteDocumentLoaded extends DeleteDocumentState{}
class DeleteDocumentError extends DeleteDocumentState{}


