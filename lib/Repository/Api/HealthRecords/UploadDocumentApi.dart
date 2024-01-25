import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mediezy_user/Model/UploadDocumentModel/upload_document_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:mediezy_user/Repository/Api/MultiFileApiClient2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadDocumentApi {
  ApiClient apiClient = ApiClient();
  MultiFileApiClient2 multiFileApiClient2 = MultiFileApiClient2();

  //* upload document
  Future<UpLoadDocumentModel> uploadDocument({required File document}) async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "user/upload_document";
    final body = {"user_id": userId, "document": document};
    print(body);
    Response response = await multiFileApiClient2.uploadFiles(
        uploadPath: basePath, bodyData: body, files: document);
    print("<<<<<< UPLOAD DOCUMENT WORKED >>>>>>");
    return UpLoadDocumentModel.fromJson(json.decode(response.body));
  }

  //* upload document Lab and Scan final
  Future<String> uploadDocumentFinal({
    required String documentId,
    required String patientId,
    required String type,
    required String doctorName,
    required String date,
    required String fileName,
    required String testName,
    required String labName,
    required String notes,
  }) async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "user/update_document";
    final body = {
      "user_id": userId,
      "document_id": documentId,
      "patient_id": patientId,
      "type": type,
      "doctor_name": doctorName,
      "date": date,
      "file_name": fileName,
      "test_name": testName,
      "lab_name": labName,
      "notes": notes,
    };
    print(body);
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("<<<<<< UPLOAD DOCUMENT FINAL WORKED >>>>>>");
    return response.body;
  }

  //* edit image document Lab and prescription api
  Future<String> editImageDocument({
    required String documentId,
    required File document,
    required String type,
  }) async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "user/update-document1";
    final body = {
      "user_id": userId,
      "document_id": documentId,
      "type": type,
      "document": document,
    };
    print(body);
    Response response =
    await multiFileApiClient2.uploadFiles(uploadPath: basePath, bodyData: body, files: document);
    print("<<<<<< UPDATE IMAGE WORKED >>>>>>");
    return response.body;
  }
}
