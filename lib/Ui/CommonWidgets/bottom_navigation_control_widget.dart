import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/AppointmentsScreen/appointments_screen.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/doctor_screen.dart';
import 'package:mediezy_user/Ui/Screens/HealthRecordScreen/health_record_screen.dart';
import 'package:mediezy_user/Ui/Screens/HomeScreen/home_screen.dart';
import 'package:mediezy_user/Ui/Screens/ProfileScreen/profile_screen.dart';

class BottomNavigationControlWidget extends StatefulWidget {
  const BottomNavigationControlWidget({super.key});

  @override
  State<BottomNavigationControlWidget> createState() =>
      _BottomNavigationControlWidgetState();
}

class _BottomNavigationControlWidgetState
    extends State<BottomNavigationControlWidget> {
  int selectedIndex = 0;
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
  }

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  List<Widget> screens = const [
    HomeScreen(),
    DoctorScreen(),
    HealthRecordScreen(),
    AppointmentsScreen(),
    ProfileScreen(),
  ];

  void selectScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectScreen,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kMainColor,
        selectedLabelStyle: TextStyle(
            color: kCardColor, fontSize: 10.sp, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(
            color: kCardColor, fontSize: 8.sp, fontWeight: FontWeight.w500),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 0 ? IconlyBold.home : IconlyLight.home,
                  color: kMainColor),
              label: "Home"),
          BottomNavigationBarItem(
              icon: ImageIcon(
                selectedIndex == 1
                    ? const AssetImage("assets/icons/doctorIconDark.png")
                    : const AssetImage("assets/icons/doctorIconLight.png"),
                color: kMainColor,
              ),
              label: "Doctor"),
              BottomNavigationBarItem(
              icon: Badge(
                backgroundColor: Colors.red.shade500,
                label: const Text("Upload"),
                child: Icon(
                    selectedIndex == 2 ? IconlyBold.chart : IconlyLight.chart,
                    color: kMainColor),
              ),
              label: "Health Records"),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 3
                      ? IconlyBold.calendar
                      : IconlyLight.calendar,
                  color: kMainColor),
              label: "Bookings"),
          
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 4 ? IconlyBold.profile : IconlyLight.profile,
                  color: kMainColor),
              label: "Profile"),
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          final connectivityResult = snapshot.data;
          if (connectivityResult == ConnectivityResult.none) {
            return const InternetHandleScreen();
          } else {
            return screens[selectedIndex];
          }
        },
      ),
    );
  }
}
