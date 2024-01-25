// ignore_for_file: deprecated_member_use

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/Doctor/doctor_model.dart';
import 'package:mediezy_user/Model/GetFavourites/get_favourites_model.dart';
import 'package:mediezy_user/Model/GetSpecialisations/get_specialisations_model.dart';
import 'package:mediezy_user/Repository/Bloc/Favourites/GetFavourites/get_favourites_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetDoctor/GetDoctors/get_doctor_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetSpecialisations/GetAllSpecialisations/get_all_specialisations_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/AllDoctorsNearYouScreen/all_dcotors_near_you_screen.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/DoctorsBySpecialisationScreen/doctors_by_specialisation_screen.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/SpecialisationsScreen/specialisations_Screen.dart';
import 'package:mediezy_user/Ui/CommonWidgets/heading_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Data/app_datas.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/Widgets/doctor_card_widget.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/Widgets/doctor_near_you_widget.dart';
import 'package:mediezy_user/Ui/Screens/ProfileScreen/SavedDoctorsScreen/saved_doctors_screen.dart';
import 'package:mediezy_user/Ui/Screens/SearchScreen/search_screen.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  int currentDotIndex = 0;
  final CarouselController controller = CarouselController();
  late DoctorModel doctorModel;
  late GetSpecialisationsModel getSpecialisationModel;
  late GetFavouritesModel getFavouritesModel;

  @override
  void initState() {
    BlocProvider.of<GetDoctorBloc>(context).add(FetchGetDoctor());
    BlocProvider.of<GetFavouritesBloc>(context).add(FetchAllFavourites());
    BlocProvider.of<GetAllSpecialisationsBloc>(context)
        .add(FetchAllSpecialisations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationControlWidget(),
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        body: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const Image(
                      image:
                          AssetImage("assets/images/doctor image search.jpg"),
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 10.h,
                      left: 25.w,
                      right: 25.w,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 45,
                          width: 300,
                          decoration: BoxDecoration(
                            color: kCardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Text(
                                  "Search your Doctor",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: kSubTextColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xFF56B89C),
                                  radius: 16,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      IconlyLight.search,
                                      color: kCardColor,
                                      size: 16.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const VerticalSpacingWidget(height: 20),
                BlocBuilder<GetDoctorBloc, GetDoctorState>(
                  builder: (context, state) {
                    if (state is GetDoctorLoaded) {
                      doctorModel =
                          BlocProvider.of<GetDoctorBloc>(context).doctorModel;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          children: [
                            HeadingWidget(
                              title: "Doctors Near You",
                              viewAllFunction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AllDoctorNearYouScreen(),
                                  ),
                                );
                              },
                            ),
                            const VerticalSpacingWidget(height: 5),
                            SizedBox(
                              height: 172.h,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: doctorModel.docters!.length,
                                  itemBuilder: (context, index) {
                                    return DoctorNearYouWidget(
                                      doctorId: doctorModel
                                          .docters![index].userId
                                          .toString(),
                                      firstName: doctorModel
                                          .docters![index].firstname
                                          .toString(),
                                      lastName: doctorModel
                                          .docters![index].secondname
                                          .toString(),
                                      imageUrl: doctorModel
                                          .docters![index].docterImage
                                          .toString(),
                                      location: doctorModel
                                          .docters![index].location
                                          .toString(),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is GetDoctorLoading) {
                      return SizedBox(
                        height: 60.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        ),
                      );
                    }
                    if (state is GetDoctorError) {
                      return Container();
                    }
                    return Container();
                  },
                ),
                const VerticalSpacingWidget(height: 15),
                //! specialities
                BlocBuilder<GetAllSpecialisationsBloc,
                    GetAllSpecialisationsState>(builder: (context, state) {
                  if (state is GetAllSpecialisationsError) {
                    return Center(
                      child: Image(
                        image: const AssetImage(
                            "assets/images/something went wrong-01.png"),
                        height: 200.h,
                        width: 200.w,
                      ),
                    );
                  }
                  if (state is GetAllSpecialisationsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
                  }
                  if (state is GetAllSpecialisationsLoaded) {
                    getSpecialisationModel =
                        BlocProvider.of<GetAllSpecialisationsBloc>(context)
                            .getSpecialisationsModel;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: HeadingWidget(
                            title: "Find by Specialisations",
                            viewAllFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SpecialisationsScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const VerticalSpacingWidget(height: 15),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: SizedBox(
                            height: 140.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: getSpecialisationModel
                                    .specializations!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 8.w, 0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorsBySpecialisationScreen(
                                              specialisationName:
                                                  getSpecialisationModel
                                                      .specializations![index]
                                                      .specialization
                                                      .toString(),
                                              specialisationId:
                                                  getSpecialisationModel
                                                      .specializations![index]
                                                      .id
                                                      .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: NetworkImage(
                                            getSpecialisationModel
                                                .specializations![index]
                                                .specializeimage
                                                .toString(),
                                          ),
                                          width: 120.w,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                }),
                const VerticalSpacingWidget(height: 15),
                BlocBuilder<GetFavouritesBloc, GetFavouritesState>(
                  builder: (context, state) {
                    if (state is GetAllFavouritesLoading) {
                      return SizedBox(
                        height: 60.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        ),
                      );
                    }
                    if (state is GetAllFavouritesError) {
                      return Container();
                    }
                    if (state is GetAllFavouritesLoaded) {
                      getFavouritesModel =
                          BlocProvider.of<GetFavouritesBloc>(context)
                              .getFavouritesModel;
                      return getFavouritesModel.favoriteDoctors!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: HeadingWidget(
                                    title: "your Favourite Doctors",
                                    viewAllFunction: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SavedDoctorsScreen()));
                                    },
                                  ),
                                ),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: getFavouritesModel
                                                .favoriteDoctors!.length >
                                            2
                                        ? 2
                                        : getFavouritesModel
                                            .favoriteDoctors!.length,
                                    itemBuilder: (context, index) {
                                      return DoctorCardWidget(
                                        doctorId: getFavouritesModel
                                            .favoriteDoctors![index].userId
                                            .toString(),
                                        firstName: getFavouritesModel
                                            .favoriteDoctors![index].firstname
                                            .toString(),
                                        lastName: getFavouritesModel
                                            .favoriteDoctors![index].secondname
                                            .toString(),
                                        imageUrl: getFavouritesModel
                                            .favoriteDoctors![index].docterImage
                                            .toString(),
                                        mainHospitalName: getFavouritesModel
                                            .favoriteDoctors![index]
                                            .mainHospital
                                            .toString(),
                                        specialisation: getFavouritesModel
                                            .favoriteDoctors![index]
                                            .specialization
                                            .toString(),
                                        location: getFavouritesModel
                                            .favoriteDoctors![index].location
                                            .toString(),
                                      );
                                    }),
                              ],
                            );
                    }
                    return Container();
                  },
                ),
                //! adbanner
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                    height: 120.h,
                    child: Swiper(
                      autoplay: true,
                      itemCount: doctorBannerImagesOneDoctor.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 6.w, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              doctorBannerImagesOneDoctor[index],
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
                BlocBuilder<GetDoctorBloc, GetDoctorState>(
                  builder: (context, state) {
                    if (state is GetDoctorLoaded) {
                      doctorModel =
                          BlocProvider.of<GetDoctorBloc>(context).doctorModel;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          children: [
                            HeadingWidget(
                              title: "Best Doctors",
                              viewAllFunction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AllDoctorNearYouScreen(),
                                  ),
                                );
                              },
                            ),
                            const VerticalSpacingWidget(height: 5),
                            SizedBox(
                              height: 172.h,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: doctorModel.docters!.length,
                                  itemBuilder: (context, index) {
                                    return DoctorNearYouWidget(
                                      doctorId: doctorModel
                                          .docters![index].userId
                                          .toString(),
                                      firstName: doctorModel
                                          .docters![index].firstname
                                          .toString(),
                                      lastName: doctorModel
                                          .docters![index].secondname
                                          .toString(),
                                      imageUrl: doctorModel
                                          .docters![index].docterImage
                                          .toString(),
                                      location: doctorModel
                                          .docters![index].location
                                          .toString(),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is GetDoctorLoading) {
                      return SizedBox(
                        height: 60.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        ),
                      );
                    }
                    if (state is GetDoctorError) {
                      return Container();
                    }
                    return Container();
                  },
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
                        padding: EdgeInsets.only(right: 8.w),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
