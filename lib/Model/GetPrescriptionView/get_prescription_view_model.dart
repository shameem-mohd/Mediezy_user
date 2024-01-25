class GetPrescriptionViewModel {
  bool? status;
  List<Prescriptions>? prescriptions;

  GetPrescriptionViewModel({this.status, this.prescriptions});

  GetPrescriptionViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['prescriptions'] != null) {
      prescriptions = <Prescriptions>[];
      json['prescriptions'].forEach((v) {
        prescriptions!.add(Prescriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (prescriptions != null) {
      data['prescriptions'] =
          prescriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prescriptions {
  int? id;
  int? userId;
  int? status;
  String? createdAt;
  String? documentPath;
  List<PatientPrescription>? patientPrescription;

  Prescriptions(
      {this.id,
      this.userId,
      this.status,
      this.createdAt,
      this.documentPath,
      this.patientPrescription});

  Prescriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    documentPath = json['document_path'];
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
    data['created_at'] = createdAt;
    data['document_path'] = documentPath;
    if (patientPrescription != null) {
      data['patient_prescription'] =
          patientPrescription!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientPrescription {
  int? id;
  int? userId;
  int? patientId;
  int? documentId;
  String? date;
  String? fileName;
  String? doctorName;
  String? notes;
  String? createdAt;
  String? updatedAt;

  PatientPrescription(
      {this.id,
      this.userId,
      this.patientId,
      this.documentId,
      this.date,
      this.fileName,
      this.doctorName,
      this.notes,
      this.createdAt,
      this.updatedAt});

  PatientPrescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    patientId = json['patient_id'];
    documentId = json['document_id'];
    date = json['date'];
    fileName = json['file_name'];
    doctorName = json['doctor_name'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['patient_id'] = patientId;
    data['document_id'] = documentId;
    data['date'] = date;
    data['file_name'] = fileName;
    data['doctor_name'] = doctorName;
    data['notes'] = notes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
