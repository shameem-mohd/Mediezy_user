// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_user/Model/GetAllMembers/get_all_members_model.dart';
import 'package:mediezy_user/Model/GetAllUploadedDocuments/get_all_uploaded_documet_model.dart';
import 'package:mediezy_user/Model/GetAllergy/get_allery_model.dart';
import 'package:mediezy_user/Model/GetMemberAsPerId/get_member_as_per_id_model.dart';
import 'package:mediezy_user/Model/GetPrescriptionView/get_prescription_view_model.dart';
import 'package:mediezy_user/Model/GetUploadedLabAndScanById/get_uploaded_lob_and_scan_by_id_model.dart';
import 'package:mediezy_user/Model/GetUploadedPrescriptionById/get_uploaded_prescription_by_id_model.dart';
import 'package:mediezy_user/Model/GetUploadedPrescriptions/get_uploaded_prescription_model.dart';
import 'package:mediezy_user/Model/GetUploadedScanningAndLabReport/get_uploaded_scanning_and_lab_report_model.dart';
import 'package:mediezy_user/Model/TimeLineModel/time_line_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:mediezy_user/Repository/Api/MultiFileApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthRecordApi {
  ApiClient apiClient = ApiClient();
  MultiFileApiClient multiFileApiClient = MultiFileApiClient();

  //* add member
  Future<String> addMember({
    required String fullName,
    required String age,
    required String relation,
    required String gender,
    required String mobileNumber,
    required String regularMedicine,
    required String allergyId,
    required String allergyName,
    required String surgeryName,
    required String treatmentTaken,
    required String illness,
    required String medicineTaken,
  }) async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "user/manage_member";
    final body = {
      "user_id": userId,
      "first_name": fullName,
      "gender": gender,
      "relation": relation,
      "age": age,
      "mobileNumber": mobileNumber,
      "regularMedicine": regularMedicine,
      "allergy_id": allergyId,
      "allergy_name": allergyName,
      "surgery_name": surgeryName,
      "treatment_taken": treatmentTaken,
      "illness": illness,
      "Medicine_Taken": medicineTaken
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<<<ADD MEMBER WORKED>>>>>>>>>>");
    return response.body;
  }

  //* get all members
  Future<GetAllMembersModel> getAllMembers() async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "user/get_patients";
    final body = {
      "user_id": userId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("<<<<<< GET ALL MEMBERS WORKED >>>>>>");
    return GetAllMembersModel.fromJson(json.decode(response.body));
  }

  //* get member as per id
  Future<GetMemberAsPerIdModel> getMemberAsPerId(
      {required String patientId}) async {
    String basePath = "patientsedit/$patientId";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<< GET MEMBER AS PER ID WORKED >>>>>>");
    return GetMemberAsPerIdModel.fromJson(json.decode(response.body));
  }

  //* update member details
  Future<String> updateMember({
    required String fullName,
    required String age,
    required String gender,
    required String patientId,
  }) async {
    String basePath = "patientupdate/$patientId";
    final body = {"firstname": fullName, "gender": gender, "age": age};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    print(body);
    print("<<<<<<<<<<EDIT MEMBER WORKED>>>>>>>>>>");
    return response.body;
  }

  //* delete member
  Future<String> deleteMember({
    required String patientId,
  }) async {
    String basePath = "DeleteMemeber/$patientId";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "DELETE", body: null);
    print("<<<<<<<<<<DELETE MEMBER WORKED>>>>>>>>>>");
    return response.body;
  }

  //* get all uploaded documents
  Future<GetAllUploadedDocumentModel> getAllUploadedDocuments(
      {required String patientId}) async {
    String basePath = "user/get_uploaded_documents";
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    final body = {"patient_id": patientId, "user_id": userId};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("<<<<<< GET ALL UPLOADED DOCUMENTSWORKED >>>>>>");
    return GetAllUploadedDocumentModel.fromJson(json.decode(response.body));
  }

  //* get all prescriptions
  Future<GetUploadedPrescriptionModel> getAllUploadedPrescriptions(
      {required String patientId}) async {
    String basePath = "user/get_uploaded_documents";
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    final body = {"patient_id": patientId, "user_id": userId, "type": "2"};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("<<<<<< GET ALL UPLOADED PRESCRIPTIONS WORKED >>>>>>");
    return GetUploadedPrescriptionModel.fromJson(json.decode(response.body));
  }

  //* get all scanning and lab reports
  Future<GetUploadedScanningAndLabModel> getAllUploadedScanningAndLabReports(
      {required String patientId}) async {
    String basePath = "user/get_uploaded_documents";
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    final body = {"patient_id": patientId, "user_id": userId, "type": "1"};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("<<<<<< GET ALL UPLOADED SCANNING AND LAB REPORTS WORKED >>>>>>");
    return GetUploadedScanningAndLabModel.fromJson(json.decode(response.body));
  }

  //* view prescriptions
  Future<GetPrescriptionViewModel> getPrescriptionView({
    required String patientId,
  }) async {
    String basePath = "user/get_prescriptions";
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    final body = {
      "patient_id": patientId,
      "user_id": userId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return GetPrescriptionViewModel.fromJson(json.decode(response.body));
  }

  //* time line
  Future<TimeLineModel> getTimeLine({
    required String patientId,
  }) async {
    String basePath = "user/reports_time_line";
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    final body = {
      "patient_id": patientId,
      "user_id": userId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return TimeLineModel.fromJson(
      json.decode(response.body),
    );
  }

  //* get uploaded prescription as per id
  Future<GetUploadedPrescriptionByIdModel> getUploadedPrescriptionAsPerId(
      {required String documentId}) async {
    String basePath = "user/get-health-record";
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    final body = {"document_id": documentId, "user_id": userId, "type": "2"};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<< GET UPLOADED PPRESCRIPTION AS PER ID WORKED >>>>>>");
    return GetUploadedPrescriptionByIdModel.fromJson(
      json.decode(response.body),
    );
  }

  //* get uploaded lab and scan as per id
  Future<GetUploadedScanAndLabByIdModel> getUploadedLabAndScanAsPerId(
      {required String documentId}) async {
    String basePath = "user/get-health-record";
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    final body = {"document_id": documentId, "user_id": userId, "type": "1"};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<< GET UPLOADED SCAN AND LAB AS PER ID WORKED >>>>>>");
    return GetUploadedScanAndLabByIdModel.fromJson(
      json.decode(response.body),
    );
  }

  //* delete uploaded document
  Future<String> deleteUploadedDocument({
    required String documentId,
    required String type,
  }) async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "user/delete-document/$userId/$documentId/$type";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "DELETE", body: null);
    print("<<<<<<<<<<DELETE DOCUMENT WORKED>>>>>>>>>>");
    return response.body;
  }

  //* get allergy
  Future<GetAllergyModel> getAllery() async {
    String basePath = "user/get_Allergy";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<< GET ALL ALLERGY WORKED >>>>>>");
    return GetAllergyModel.fromJson(json.decode(response.body));
  }
}
