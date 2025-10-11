import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/utils/responsive.dart';
import 'package:habitsbegone/view/cousre_view.dart';
import 'package:habitsbegone/view/elec_magnetic_view.dart';
import 'package:habitsbegone/view/hypnotherapy_view.dart';
import 'package:habitsbegone/view/massage_view.dart';
import 'package:habitsbegone/view/osteopathy_view.dart';
import 'package:habitsbegone/view/profile_view.dart';
import 'package:habitsbegone/widgets/bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
final uid = user?.uid;

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    updateLoginTime(context);
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> updateLoginTime(BuildContext context) async {
    await _firestore.collection('users').doc(uid).update({
      'lastOnline': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(child: _getBodyContent()),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }

  Widget _getBodyContent() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return MyTakenCousreView();
      case 2:
        return ProfileView();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change Your Life with",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.teachers(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColorBlack,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "Hypnosis!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.teachers(
                      fontWeight: FontWeight.w400,
                      color: AppColors.skyblue,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset("assets/images/Frame 27.svg"),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HypnotherapyView()),
                    ),
                // Navigator.pushNamed(
                //   context,
                //   RoutesName.hypnotherapyview,
                // ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: Responsive.w(44),
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: AppColors.seconadryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/Layer_1 (1).svg"),
                        SizedBox(height: Responsive.h(2)),
                        Text(
                          "Hypnotherapy",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.teachers(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                            fontSize: Responsive.textScaleFactor * 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MassageTherapyView()),
                    ),
                // () => Navigator.pushNamed(
                //   context,
                //   RoutesName.massagetherapyview,
                // ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: Responsive.w(44),
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: AppColors.yellow,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/Layer_1 (4).svg"),
                        SizedBox(height: Responsive.h(2)),
                        Text(
                          "Massage Therapy",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.teachers(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColorBlack,
                            fontSize: Responsive.textScaleFactor * 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ElecMagneticView()),
                    ),
                //  Navigator.pushNamed(
                //   context,
                //   RoutesName.elecmagnetictherapy,
                // ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: Responsive.w(44),
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: AppColors.skyblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/Layer_1 (2).svg"),
                        SizedBox(height: Responsive.h(2)),
                        Text(
                          "Elec-magnetic Therapy",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.teachers(
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            fontSize: Responsive.textScaleFactor * 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => OsteopathyView()),
                    ),
                // () =>
                //     Navigator.pushNamed(context, RoutesName.osteopathyview),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: Responsive.w(44),
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: AppColors.waterBlueColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/Layer_1 (3).svg"),
                        SizedBox(height: Responsive.h(2)),
                        Text(
                          "Osteopathy",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.teachers(
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            fontSize: Responsive.textScaleFactor * 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
