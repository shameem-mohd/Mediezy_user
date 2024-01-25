import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/BookAppointment/AutoFetch/auto_fetch_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/BookAppointment/BookAppointmets/book_appointment_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/BookAppointment/GetFamilyMembers/get_family_members_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Favourites/AddFavourites/add_favourites_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Favourites/GetFavourites/get_favourites_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetAppointment/GetCompletedAppointments/get_completed_appointments_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetAppointment/GetUpcomingAppointment/get_upcoming_appointment_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetDoctor/GetDoctorById/get_doctor_by_id_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetDoctor/GetDoctors/get_doctor_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetHealthSymptomsAndDoctor/GetDoctorAsPerSymptoms/get_doctor_as_per_symptoms_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetHealthSymptomsAndDoctor/GetHealthSymptoms/get_health_symptoms_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetRecentlyBookedDoctor/get_recently_booked_doctors_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetSpecialisations/GetAllSpecialisations/get_all_specialisations_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetSpecialisations/GetDoctorsAsPerSpecialisation/get_doctors_as_per_specialisation_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetSymptoms/get_symptoms_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthCategories/GetDoctorsByHealthCategory/get_doctors_by_health_category_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthCategories/GetHealthCategories/get_health_categories_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/AddMember/add_member_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/DeleteDocument/delete_document_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/DeleteMember/delete_member_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/EditMember/edit_member_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllLabAndScanningReports/get_all_scanning_and_lab_reports_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllMembers/get_all_members_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllPrescriptions/get_all_prescriptions_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllUploadedDocuments/get_all_uploaded_documents_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetAllergy/get_allergy_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetMemberById/get_member_by_id_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetPrescriptionView/get_prescription_view_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetUploadedLabAndScanById/get_uploaded_scan_and_lab_by_id_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/GetUploadedPrescriptionById/get_uploaded_prescription_by_id_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/TimeLine/time_line_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/UploadDocument/UploadDocument/upload_document_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthRecord/UploadDocument/UploadDocumentFinal/upload_document_lab_and_scan_final_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/LoginAndSignUp/login_and_signup_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/EditUser/edit_user_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/GetUser/get_user_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/UploadUserImage/upload_user_image_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/SearchDoctor/search_doctor_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(create: (context) => GetDoctorBloc()),
        BlocProvider(create: (context) => GetDoctorByIdBloc()),
        BlocProvider(create: (context) => LoginAndSignupBloc()),
        BlocProvider(create: (context) => GetTokenBloc()),
        BlocProvider(create: (context) => GetSymptomsBloc()),
        BlocProvider(create: (context) => BookAppointmentBloc()),
        BlocProvider(create: (context) => GetUpcomingAppointmentBloc()),
        BlocProvider(create: (context) => GetCompletedAppointmentsBloc()),
        BlocProvider(create: (context) => GetAllSpecialisationsBloc()),
        BlocProvider(create: (context) => GetDoctorsAsPerSpecialisationBloc()),
        BlocProvider(create: (context) => AddFavouritesBloc()),
        BlocProvider(create: (context) => GetFavouritesBloc()),
        BlocProvider(create: (context) => SearchDoctorBloc()),
        BlocProvider(create: (context) => GetHealthCategoriesBloc()),
        BlocProvider(create: (context) => GetDoctorsByHealthCategoryBloc()),
        BlocProvider(create: (context) => GetUserBloc()),
        BlocProvider(create: (context) => EditUserBloc()),
        BlocProvider(create: (context) => AddMemberBloc()),
        BlocProvider(create: (context) => GetAllMembersBloc()),
        BlocProvider(create: (context) => UploadDocumentBloc()),
        BlocProvider(create: (context) => UploadDocumentFinalBloc()),
        BlocProvider(create: (context) => GetMemberByIdBloc()),
        BlocProvider(create: (context) => EditMemberBloc()),
        BlocProvider(create: (context) => DeleteMemberBloc()),
        BlocProvider(create: (context) => GetAllUploadedDocumentsBloc()),
        BlocProvider(create: (context) => GetAllPrescriptionsBloc()),
        BlocProvider(create: (context) => GetAllScanningAndLabReportsBloc()),
        BlocProvider(create: (context) => GetRecentlyBookedDoctorsBloc()),
        BlocProvider(create: (context) => GetPrescriptionViewBloc()),
        BlocProvider(create: (context) => TimeLineBloc()),
        BlocProvider(create: (context) => UploadUserImageBloc()),
        BlocProvider(create: (context) => GetHealthSymptomsBloc()),
        BlocProvider(create: (context) => GetDoctorAsPerSymptomsBloc()),
        BlocProvider(create: (context) => GetUploadedPrescriptionByIdBloc()),
        BlocProvider(create: (context) => GetUploadedScanAndLabByIdBloc()),
        BlocProvider(create: (context) => GetAllergyBloc()),
        BlocProvider(create: (context) => DeleteDocumentBloc()),
        BlocProvider(create: (context) => GetFamilyMembersBloc()),
        BlocProvider(create: (context) => AutoFetchBloc()),
      ];
}
