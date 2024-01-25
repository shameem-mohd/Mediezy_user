class GetUploadedPrescriptionModel {
  bool? status;
  List<DocumentData>? documentData;

  GetUploadedPrescriptionModel({this.status, this.documentData});

  GetUploadedPrescriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['document_data'] != null) {
      documentData = <DocumentData>[];
      json['document_data'].forEach((v) {
        documentData!.add(DocumentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (documentData != null) {
      data['document_data'] =
          documentData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentData {
  int? id;
  int? userId;
  int? status;
  int? patientId;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? documentPath;
  int? hoursAgo;
  String? date;
  String? patient;
  List<PatientPrescription>? patientPrescription;

  DocumentData(
      {this.id,
      this.userId,
      this.status,
      this.patientId,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.documentPath,
      this.hoursAgo,
      this.date,
      this.patient,
      this.patientPrescription});

  DocumentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    patientId = json['patient_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    documentPath = json['document_path'];
    hoursAgo = json['hours_ago'];
    date = json['date'];
    patient = json['patient'];
    if (json['patient_prescription'] != null) {
      patientPrescription = <PatientPrescription>[];
      json['patient_prescription'].forEach((v) {
        patientPrescription!.add(PatientPrescription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['status'] = status;
    data['patient_id'] = patientId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['document_path'] = documentPath;
    data['hours_ago'] = hoursAgo;
    data['date'] = date;
    data['patient'] = patient;
    if (patientPrescription != null) {
      data['patient_prescription'] =
          patientPrescription!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientPrescription {
  int? id;
  int? documentId;
  String? date;
  String? doctorName;

  PatientPrescription({this.id, this.documentId, this.date, this.doctorName});

  PatientPrescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentId = json['document_id'];
    date = json['date'];
    doctorName = json['doctor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['document_id'] = documentId;
    data['date'] = date;
    data['doctor_name'] = doctorName;
    return data;
  }
}
