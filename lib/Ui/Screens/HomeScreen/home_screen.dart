// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetAppointments/get_upcoming_appointments_model.dart';
import 'package:mediezy_user/Model/GetRecentlyBookedDoctor/get_recently_booked_doctor_model.dart';
import 'package:mediezy_user/Model/GetSymptomAndDoctor/get_health_symptoms_model.dart';
import 'package:mediezy_user/Model/HealthCategories/get_health_categories_model.dart';
import 'package:mediezy_user/Model/Profile/get_user_model.dart';
import 'package:mediezy_user/Repository/Bloc/GetAppointment/GetUpcomingAppointment/get_upcoming_appointment_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetHealthSymptomsAndDoctor/GetHealthSymptoms/get_health_symptoms_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetRecentlyBookedDoctor/get_recently_booked_doctors_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthCategories/GetHealthCategories/get_health_categories_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/GetUser/get_user_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/heading_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Data/app_datas.dart';
import 'package:mediezy_user/Ui/Screens/AppointmentsScreen/Widgets/appointment_card_widget.dart';
import 'package:mediezy_user/Ui/Screens/AppointmentsScreen/appointments_screen.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/AllDoctorsNearYouScreen/all_dcotors_near_you_screen.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/Widgets/doctor_card_widget.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/AddPatientScreen/AddPatientScreen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/health_record_screen.dart';
import 'package:mediezy_user/Ui/Screens/HomeScreen/DoctorsByHealthSymptomsScreen/doctor_by_health_symptoms_screen.dart';
import 'package:mediezy_user/Ui/Screens/HomeScreen/HealthSymptomsListingScreen/health_symptoms_listing_screen.dart';
import 'package:mediezy_user/Ui/Screens/HomeScreen/Widgets/health_concern_widget.dart';
import 'package:mediezy_user/Ui/Screens/ProfileScreen/RecentBookedDoctorsScreen/recent_booked_doctors_screen.dart';
import 'package:mediezy_user/Ui/Screens/ProfileScreen/profile_screen.dart';
import 'package:mediezy_user/Ui/Screens/SearchScreen/search_screen.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetUpComingAppointmentsModel getUpComingAppointmentsModel;
  late GetHealthCategoriesModel getHealthCategoriesModel;
  late GetRecentlyBookedDoctorModel getRecentlyBookedDoctorModel;
  late GetUserModel getUserModel;
  late GetHealthSymptomsModel getHealthSymptomsModel;
  int currentDotIndex = 0;
  final CarouselController controller = CarouselController();
  String? firstName;
  String? lastName;

  Future<void> getUserName() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      firstName = preferences.getString('firstName');
      lastName = preferences.getString('lastName');
    });
  }

  late Timer pollingTimer;

  @override
  void initState() {
    super.initState();
    getUserName();
    BlocProvider.of<GetUpcomingAppointmentBloc>(context)
        .add(FetchUpComingAppointments());
    BlocProvider.of<GetHealthCategoriesBloc>(context)
        .add(FetchHealthCategories());
    BlocProvider.of<GetUserBloc>(context).add(FetchUserDetails());
    BlocProvider.of<GetRecentlyBookedDoctorsBloc>(context)
        .add(FetchRecentlyBookedDoctors());
    BlocProvider.of<GetHealthSymptomsBloc>(context)
        .add(FetchAllHealthSymptoms());
    startPolling();
  }

  void startPolling() async {
    pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      BlocProvider.of<GetUpcomingAppointmentBloc>(context)
          .add(FetchUpComingAppointments());
    });
  }

  void stopPolling() {
    pollingTimer.cancel();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      beginOffset: const Offset(0, 0.3),
      endOffset: const Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
      child: WillPopScope(
        onWillPop: () async {
          GeneralServices.instance
              .appCloseDialogue(context, "Are you want to Exit", () async {
            SystemNavigator.pop();
          });
          return Future.value(false);
        },
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //     backgroundColor: kMainColor,
          //     onPressed: () {},
          //     child: Image(
          //       image: AssetImage("assets/icons/add member.png"),

          //       fit: BoxFit.fill,
          //     )),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 69, 143, 104),
                        Color(0xFF313C75)
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacingWidget(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                              const HorizontalSpacingWidget(width: 5),
                              Text(
                                "Kochi",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Image(
                            image: const AssetImage(
                              "assets/icons/mediezy logo small.png",
                            ),
                            height: 40.h,
                            width: 100.w,
                          )
                        ],
                      ),
                      BlocBuilder<GetUserBloc, GetUserState>(
                        builder: (context, state) {
                          if (state is GetUserDetailsError) {
                            return const Text("No Name");
                          }
                          if (state is GetUserDetailsLoaded) {
                            getUserModel = BlocProvider.of<GetUserBloc>(context)
                                .getUserModel;
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Hi, ${getUserModel.userdetails!.firstname} ${getUserModel.userdetails!.lastname}",
                                style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your one stop solution for\nQuick and easy consultation",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const AddPatientScreen();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 48.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Center(
                                child: Text(
                                  "Add\nPatient",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const VerticalSpacingWidget(height: 5),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          height: 40.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: kCardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Search Your needs",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kSubTextColor),
                              ),
                              Icon(
                                IconlyLight.search,
                                color: kMainColor,
                                size: 20.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacingWidget(height: 10),
                //! banner one
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                    height: 120.h,
                    child: Swiper(
                      autoplay: true,
                      itemCount: doctorBannerImagesOneHome.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 6.w, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.asset(
                              doctorBannerImagesOneHome[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }),
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                            color: Colors.grey[200],
                            activeColor: Colors.red[400],
                            size: 8.sp,
                            activeSize: 8.sp),
                      ),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                //! your appointments
                BlocBuilder<GetUpcomingAppointmentBloc,
                    GetUpcomingAppointmentState>(
                  builder: (context, state) {
                    if (state is GetUpComingAppointmentLoading) {
                      return SizedBox(
                        height: 60.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        ),
                      );
                    }
                    if (state is GetUpComingAppointmentError) {
                      return Center(
                        child: Image(
                          image: const AssetImage(
                              "assets/images/something went wrong-01.png"),
                          height: 200.h,
                          width: 200.w,
                        ),
                      );
                    }
                    if (state is GetUpComingAppointmentLoaded) {
                      if (state.isLoaded) {
                        getUpComingAppointmentsModel =
                            BlocProvider.of<GetUpcomingAppointmentBloc>(context)
                                .getUpComingAppointmentsModel;
                        return getUpComingAppointmentsModel.appointments == null
                            ? Container()
                            : Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: HeadingWidget(
                                      title: "Your Appointments",
                                      viewAllFunction: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AppointmentsScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails!
                                                  .length >
                                              2
                                          ? 2
                                          : getUpComingAppointmentsModel
                                              .appointments!
                                              .appointmentsDetails!
                                              .length,
                                      itemBuilder: (context, index) {
                                        return AppointmentCardWidget(
                                          doctorId: getUpComingAppointmentsModel
                                              .appointments!
                                              .appointmentsDetails![index]
                                              .doctorId
                                              .toString(),
                                          clinicList:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .clincs!
                                                  .toList(),
                                          bookedClinicName:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .mainHospital
                                                  .toString(),
                                          leaveMessage:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .leaveMessage
                                                  .toString(),
                                          docterImage:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .docterImage
                                                  .toString(),
                                          docterFirstname:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .firstname
                                                  .toString(),
                                          docterSecondName:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .secondname
                                                  .toString(),
                                          appointmentFor:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .mainSymptoms!
                                                  .first
                                                  .symtoms
                                                  .toString(),
                                          tokenNumber:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .tokenNumber
                                                  .toString(),
                                          appointmentDate:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .date
                                                  .toString(),
                                          appointmentTime:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .startingtime
                                                  .toString(),
                                          patientName:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .patientName
                                                  .toString(),
                                          bookinTime:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .tokenBookingTime
                                                  .toString(),
                                          bookingDate:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .tokenBookingDate
                                                  .toString(),
                                          consultationStartingTime:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .consultationStartsfrom
                                                  .toString(),
                                          earlyTime:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .doctorEarlyFor
                                                  .toString(),
                                          estimatedArrivalTime:
                                              getUpComingAppointmentsModel
                                                          .appointments!
                                                          .appointmentsDetails![
                                                              index]
                                                          .estimateTime ==
                                                      null
                                                  ? getUpComingAppointmentsModel
                                                      .appointments!
                                                      .appointmentsDetails![
                                                          index]
                                                      .startingtime
                                                      .toString()
                                                  : getUpComingAppointmentsModel
                                                      .appointments!
                                                      .appointmentsDetails![
                                                          index]
                                                      .estimateTime
                                                      .toString(),
                                          lateTime: getUpComingAppointmentsModel
                                              .appointments!
                                              .appointmentsDetails![index]
                                              .doctorLateFor
                                              .toString(),
                                          liveToken:
                                              getUpComingAppointmentsModel
                                                      .appointments
                                                      ?.appointmentsDetails![
                                                          index]
                                                      .currentOngoingToken ??
                                                  '0'.toString(),
                                        );
                                      }),
                                ],
                              );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        );
                      }
                    }
                    return Container();
                  },
                ),
                BlocBuilder<GetHealthCategoriesBloc, GetHealthCategoriesState>(
                  builder: (context, state) {
                    if (state is GetHealthCategoriesLoading) {
                      return SizedBox(
                        height: 60.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        ),
                      );
                    }
                    if (state is GetHealthCategoriesError) {
                      return Container();
                    }
                    if (state is GetHealthCategoriesLoaded) {
                      getHealthCategoriesModel =
                          BlocProvider.of<GetHealthCategoriesBloc>(context)
                              .getHealthCategoriesModel;
                      return getHealthCategoriesModel.categories!.isEmpty
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //! health concern
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text(
                                      "Browse by Health Concern",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: kSubTextColor),
                                    ),
                                  ),
                                  const VerticalSpacingWidget(height: 10),
                                  GridView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: getHealthCategoriesModel
                                          .categories!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: .65),
                                      itemBuilder: (context, index) {
                                        return HealthConcernWidget(
                                          title: getHealthCategoriesModel
                                              .categories![index].categoryName
                                              .toString(),
                                          imageUrl: getHealthCategoriesModel
                                              .categories![index].image
                                              .toString(),
                                          healthCategoryId:
                                              getHealthCategoriesModel
                                                  .categories![index].id
                                                  .toString(),
                                        );
                                      }),
                                ],
                              ),
                            );
                    }
                    return Container();
                  },
                ),
                //! recently added doctors
                BlocBuilder<GetRecentlyBookedDoctorsBloc,
                    GetRecentlyBookedDoctorsState>(
                  builder: (context, state) {
                    if (state is GetRecentlyBookedDoctorLoading) {
                      return SizedBox(
                        height: 60.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        ),
                      );
                    }
                    if (state is GetRecentlyBookedDoctorError) {
                      return Center(
                        child: Image(
                          image: const AssetImage(
                              "assets/images/something went wrong-01.png"),
                          height: 200.h,
                          width: 200.w,
                        ),
                      );
                    }
                    if (state is GetRecentlyBookedDoctorLoaded) {
                      getRecentlyBookedDoctorModel =
                          BlocProvider.of<GetRecentlyBookedDoctorsBloc>(context)
                              .getRecentlyBookedDoctorModel;
                      return getRecentlyBookedDoctorModel.doctorData == null
                          ? Container()
                          : Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: HeadingWidget(
                                    title: "Recent booked doctors",
                                    viewAllFunction: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RecentBookedDoctorsScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: getRecentlyBookedDoctorModel
                                                .doctorData!.length >
                                            2
                                        ? 2
                                        : getRecentlyBookedDoctorModel
                                            .doctorData!.length,
                                    itemBuilder: (context, index) {
                                      return DoctorCardWidget(
                                        doctorId: getRecentlyBookedDoctorModel
                                            .doctorData![index].userId
                                            .toString(),
                                        firstName: getRecentlyBookedDoctorModel
                                            .doctorData![index].firstname
                                            .toString(),
                                        lastName: getRecentlyBookedDoctorModel
                                            .doctorData![index].secondname
                                            .toString(),
                                        imageUrl: getRecentlyBookedDoctorModel
                                            .doctorData![index].docterImage
                                            .toString(),
                                        mainHospitalName:
                                            getRecentlyBookedDoctorModel
                                                .doctorData![index].mainHospital
                                                .toString(),
                                        specialisation:
                                            getRecentlyBookedDoctorModel
                                                .doctorData![index]
                                                .specialization
                                                .toString(),
                                        location: getRecentlyBookedDoctorModel
                                            .doctorData![index].location
                                            .toString(),
                                      );
                                    }),
                              ],
                            );
                    }
                    return Container();
                  },
                ),
                const VerticalSpacingWidget(height: 20),
                //! doctor booking screens
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllDoctorNearYouScreen(),
                      ),
                    );
                  },
                  child: const Image(
                    image: AssetImage("assets/images/doctor booking image.jpg"),
                  ),
                ),
                const VerticalSpacingWidget(height: 20),
                //! health record
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HealthRecordScreen(),
                      ),
                    );
                  },
                  child: const Image(
                    image: AssetImage("assets/images/health record image.jpg"),
                  ),
                ),
                const VerticalSpacingWidget(height: 20),
                //! second adbanner
                SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: doctorBannerImagesTwoHome.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 4.w, left: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            doctorBannerImagesTwoHome[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const VerticalSpacingWidget(height: 20),
                //! health symptoms
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: HeadingWidget(
                    title: "Browse by Symptoms",
                    viewAllFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HealthSymptomsListingScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalSpacingWidget(height: 10),
                BlocBuilder<GetHealthSymptomsBloc, GetHealthSymptomsState>(
                    builder: (context, state) {
                  if (state is GetHealthSymptomsLoading) {
                    return SizedBox(
                      height: 60.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      ),
                    );
                  }
                  if (state is GetHealthSymptomsError) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  if (state is GetHealthSymptomsLoaded) {
                    getHealthSymptomsModel =
                        BlocProvider.of<GetHealthSymptomsBloc>(context)
                            .getHealthSymptomsModel;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 0.70),
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorByHealthSymptomsScreen(
                                      healthSymptomsName: getHealthSymptomsModel
                                          .categories![index].categoryName
                                          .toString(),
                                      healthSymptomsId: getHealthSymptomsModel
                                          .categories![index].id
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: NetworkImage(
                                    getHealthSymptomsModel
                                        .categories![index].image
                                        .toString(),
                                  ),
                                  width: 120.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  }
                  return Container();
                }),

                const VerticalSpacingWidget(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
