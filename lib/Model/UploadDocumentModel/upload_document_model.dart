class UpLoadDocumentModel {
  bool? status;
  String? response;
  Document? document;

  UpLoadDocumentModel({this.status, this.response, this.document});

  UpLoadDocumentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    document = json['document'] != null
        ? Document.fromJson(json['document'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response'] = response;
    if (document != null) {
      data['document'] = document!.toJson();
    }
    return data;
  }
}

class Document {
  String? userId;
  String? document;
  String? patientId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Document(
      {this.userId,
      this.document,
      this.patientId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Document.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    document = json['document'];
    patientId = json['patient_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['document'] = document;
    data['patient_id'] = patientId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
