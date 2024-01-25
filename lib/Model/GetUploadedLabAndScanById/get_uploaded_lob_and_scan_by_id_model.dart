class GetUploadedScanAndLabByIdModel {
  bool? status;
  String? response;
  HealthRecord? healthRecord;

  GetUploadedScanAndLabByIdModel(
      {this.status, this.response, this.healthRecord});

  GetUploadedScanAndLabByIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    healthRecord = json['health_record'] != null
        ? HealthRecord.fromJson(json['health_record'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response'] = response;
    if (healthRecord != null) {
      data['health_record'] = healthRecord!.toJson();
    }
    return data;
  }
}

class HealthRecord {
  int? id;
  int? userId;
  int? patientId;
  int? documentId;
  String? testName;
  String? date;
  String? labName;
  String? fileName;
  String? doctorName;
  String? notes;
  String? createdAt;
  String? updatedAt;
  String? document;

  HealthRecord(
      {this.id,
      this.userId,
      this.patientId,
      this.documentId,
      this.testName,
      this.date,
      this.labName,
      this.fileName,
      this.doctorName,
      this.notes,
      this.createdAt,
      this.updatedAt,
      this.document});

  HealthRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    patientId = json['patient_id'];
    documentId = json['document_id'];
    testName = json['test_name'];
    date = json['date'];
    labName = json['lab_name'];
    fileName = json['file_name'];
    doctorName = json['doctor_name'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['patient_id'] = patientId;
    data['document_id'] = documentId;
    data['test_name'] = testName;
    data['date'] = date;
    data['lab_name'] = labName;
    data['file_name'] = fileName;
    data['doctor_name'] = doctorName;
    data['notes'] = notes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['document'] = document;
    return data;
  }
}
