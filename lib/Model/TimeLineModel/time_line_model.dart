class TimeLineModel {
  bool? status;
  List<TimeLine>? timeLine;

  TimeLineModel({this.status, this.timeLine});

  TimeLineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['time_line'] != null) {
      timeLine = <TimeLine>[];
      json['time_line'].forEach((v) {
        timeLine!.add(TimeLine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (timeLine != null) {
      data['time_line'] = timeLine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeLine {
  int? id;
  int? userId;
  int? status;
  String? createdAt;
  String? documentPath;
  List<LabReport>? labReport;

  TimeLine(
      {this.id,
      this.userId,
      this.status,
      this.createdAt,
      this.documentPath,
      this.labReport});

  TimeLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    documentPath = json['document_path'];
    if (json['lab_report'] != null) {
      labReport = <LabReport>[];
      json['lab_report'].forEach((v) {
        labReport!.add(LabReport.fromJson(v));
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
    if (labReport != null) {
      data['lab_report'] = labReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LabReport {
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

  LabReport(
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
      this.updatedAt});

  LabReport.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
