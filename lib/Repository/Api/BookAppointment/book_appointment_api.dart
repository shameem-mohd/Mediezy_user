import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_user/Model/AutoFetch/auto_fetch_model.dart';
import 'package:mediezy_user/Model/BookAppointment/book_appointment_model.dart';
import 'package:mediezy_user/Model/GetFamilyMembers/get_family_members_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointmentApi {
  ApiClient apiClient = ApiClient();

  Future<BookAppointmentModel> bookAppointment({
    required String patientName,
    required String doctorId,
    required String clinicId,
    required String date,
    required String regularmedicine,
    required String whenitcomes,
    required String whenitstart,
    required String tokenTime,
    required String tokenNumber,
    required String gender,
    required String age,
    required String mobileNo,
    required String bookingType,
    required String endingTime,
    required List<String> appoinmentfor1,
    required List<int> appoinmentfor2,
  }) async {
    String basePath = "TokenBooking";
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    final body = {
      "BookedPerson_id": userId,
      "PatientName": patientName,
      "date": date,
      "regularmedicine": regularmedicine,
      "whenitcomes": whenitcomes,
      "whenitstart": whenitstart,
      "TokenTime": tokenTime,
      "TokenNumber": tokenNumber,
      "MobileNo": mobileNo,
      "age": age,
      "gender": gender,
      "Appoinmentfor1": appoinmentfor1,
      "Appoinmentfor2": appoinmentfor2,
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      "Bookingtype": bookingType,
      "EndTokenTime": endingTime
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<<<BOOK APPOINTMENT WORKED SUCCESSFULLY>>>>>>>>>>");
    return BookAppointmentModel.fromJson(json.decode(response.body));
  }

  //* get family members
  Future<GetFamilyMembersModel> getFamilyMembers() async {
    String basePath = "GetFamily";
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    final body = {
      "user_id": userId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<<<GET FAMILY MEMBERS WORKED>>>>>>>>>>");
    return GetFamilyMembersModel.fromJson(json.decode(response.body));
  }

  //* auto fetch details
  Future<AutoFetchModel> autoFetchDetails(
      {required String section, required String patientId}) async {
    String basePath = "Autofetch";
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    final body = {
      "user_id": userId,
      "section": section,
      "patient_id": patientId
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<<<AUTO FETCH DETAILS WORKED>>>>>>>>>>");
    return AutoFetchModel.fromJson(json.decode(response.body));
  }
}
