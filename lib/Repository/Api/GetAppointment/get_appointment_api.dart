import 'dart:convert';

import 'package:http/http.dart';
import 'package:mediezy_user/Model/GetAppointments/get_completed_appointments_model.dart';
import 'package:mediezy_user/Model/GetAppointments/get_upcoming_appointments_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAppointmentApi {
  ApiClient apiClient = ApiClient();

  //* get up coming appointments
  Future<GetUpComingAppointmentsModel> getUpComingApointments() async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "user/userAppoinments/$userId";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<< Get All UPCOMING Appointments Are Worked >>>>>>");
    return GetUpComingAppointmentsModel.fromJson(json.decode(response.body));
  }


  //* get completd appointments
  Future<GetCompletedAppointmentsModel>getCompletedApointments() async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "user/userCompletedAppoinments/$userId";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<< Get All COMPLETED Appointments Are Worked >>>>>>");
    return GetCompletedAppointmentsModel.fromJson(json.decode(response.body));
  }
}
