import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/utils/responsive.dart';
import 'package:habitsbegone/view/auth/login_view.dart';
import 'package:habitsbegone/view/cousre_purchase/pay.dart';
import 'package:habitsbegone/view/cousre_view.dart';
import 'package:habitsbegone/view/elec_magnetic_view.dart';
import 'package:habitsbegone/view/hypnotherapy_view.dart';
import 'package:habitsbegone/view/massage_view.dart';
import 'package:habitsbegone/view/osteopathy_view.dart';
import 'package:habitsbegone/view/profile_view.dart';
import 'package:habitsbegone/view/support_view.dart';
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
  Stream<DocumentSnapshot<Map<String, dynamic>>>? _userStream;

  @override
  void initState() {
    super.initState();
    updateLoginTime(context);
    _checkUserStatus();
    _listenToUserStatus();
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

  void _listenToUserStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _userStream =
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots();

    _userStream!.listen((snapshot) async {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data['isActive'] == false) {
          // 🔹 User is blocked
          await FirebaseAuth.instance.signOut();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Your account has been blocked.'),
                backgroundColor: Colors.redAccent,
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginView()),
              (route) => false,
            );
          }
        }
      }
    });
  }

  // id user is Blocked show him Loginn  screen
  void _checkUserStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (doc.exists && doc['isActive'] == false) {
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your account has been blocked.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      }
    }
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
        return _buildHomeContent(context);
      case 1:
        return MyTakenCourseView();
      case 2:
        return ProfileView();
      case 3:
        return BuyCourseView();
      default:
        return _buildHomeContent(context);
    }
  }

  Widget _buildHomeContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Change Your Life with",
            style: GoogleFonts.teachers(
              fontWeight: FontWeight.w400,
              color: AppColors.textColorBlack,
              fontSize: 28,
            ),
          ),
          Text(
            "Hypnosis!",
            style: GoogleFonts.teachers(
              fontWeight: FontWeight.w400,
              color: AppColors.skyblue,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 16),

          // 🔥 Dynamic Course Grid
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('courses').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No courses available right now."),
                  );
                }

                final courses = snapshot.data!.docs;

                // Random color list for cards
                final List<Color> colorOptions = [
                  AppColors.seconadryColor,
                  AppColors.yellow,
                  AppColors.skyblue,
                  AppColors.waterBlueColor,
                  Colors.pinkAccent,
                  Colors.lightGreen,
                  Colors.blueAccent,
                  Colors.tealAccent,
                ];
                final random = Random();

                return GridView.builder(
                  itemCount: courses.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final data = courses[index].data() as Map<String, dynamic>;
                    final courseId = courses[index].id;
                    final name = data['name'] ?? 'Unnamed Course';
                    final iconPath =
                        data['icon'] ?? "assets/icons/hypnotherapy.svg";
                    final randomColor =
                        colorOptions[random.nextInt(colorOptions.length)];

                    return GestureDetector(
                      onTap: () {
                        _navigateToCourse(context, courseId, name);
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: randomColor,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(iconPath, height: 40),
                            const SizedBox(height: 10),
                            Text(
                              name,
                              style: GoogleFonts.teachers(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                                fontSize: Responsive.textScaleFactor * 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔄 Navigate to correct course screen based on courseId
  // void _navigateToCourse(BuildContext context, String courseId) {
  //   Widget page;
  //   switch (courseId.toLowerCase()) {
  //     case 'hypnotherapy':
  //       page = HypnotherapyView();
  //       break;
  //     case 'massage_therapy':
  //       page = MassageTherapyView();
  //       break;
  //     case 'elec_magnetic_therapy':
  //       page = ElecMagneticView();
  //       break;
  //     case 'osteopathy':
  //       page = OsteopathyView();
  //       break;
  //     default:
  //       page = Scaffold(
  //         appBar: AppBar(title: Text(courseId)),
  //         body: Center(child: Text("No view defined for this course.")),
  //       );
  //   }

  //   Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  // }

  void _navigateToCourse(
    BuildContext context,
    String courseId,
    String courseName,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) =>
                SupportUploadView(courseId: courseId, courseName: courseName),
      ),
    );
  }

  // Widget _buildHomeContent() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  //     child: Column(
  //       children: [
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "Change Your Life with",
  //                   textAlign: TextAlign.center,
  //                   style: GoogleFonts.teachers(
  //                     fontWeight: FontWeight.w400,
  //                     color: AppColors.textColorBlack,
  //                     fontSize: 28,
  //                   ),
  //                 ),
  //                 Text(
  //                   "Hypnosis!",
  //                   textAlign: TextAlign.center,
  //                   style: GoogleFonts.teachers(
  //                     fontWeight: FontWeight.w400,
  //                     color: AppColors.skyblue,
  //                     fontSize: 28,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             // SvgPicture.asset("assets/images/Frame 27.svg"),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //               onTap:
  //                   () => Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (_) => HypnotherapyView()),
  //                   ),
  //               // Navigator.pushNamed(
  //               //   context,
  //               //   RoutesName.hypnotherapyview,
  //               // ),
  //               child: Container(
  //                 padding: EdgeInsets.all(10),
  //                 width: Responsive.w(44),
  //                 height: 110,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(22),
  //                   color: AppColors.seconadryColor,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(6.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       SvgPicture.asset("assets/images/Layer_1 (1).svg"),
  //                       SizedBox(height: Responsive.h(2)),
  //                       Text(
  //                         "Hypnotherapy",
  //                         textAlign: TextAlign.center,
  //                         style: GoogleFonts.teachers(
  //                           fontWeight: FontWeight.w500,
  //                           color: AppColors.primaryColor,
  //                           fontSize: Responsive.textScaleFactor * 12,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap:
  //                   () => Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (_) => MassageTherapyView()),
  //                   ),
  //               // () => Navigator.pushNamed(
  //               //   context,
  //               //   RoutesName.massagetherapyview,
  //               // ),
  //               child: Container(
  //                 padding: EdgeInsets.all(10),
  //                 width: Responsive.w(44),
  //                 height: 110,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(22),
  //                   color: AppColors.yellow,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(6.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       SvgPicture.asset("assets/images/Layer_1 (4).svg"),
  //                       SizedBox(height: Responsive.h(2)),
  //                       Text(
  //                         "Massage Therapy",
  //                         textAlign: TextAlign.center,
  //                         style: GoogleFonts.teachers(
  //                           fontWeight: FontWeight.w500,
  //                           color: AppColors.textColorBlack,
  //                           fontSize: Responsive.textScaleFactor * 12,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //               onTap:
  //                   () => Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (_) => ElecMagneticView()),
  //                   ),
  //               //  Navigator.pushNamed(
  //               //   context,
  //               //   RoutesName.elecmagnetictherapy,
  //               // ),
  //               child: Container(
  //                 padding: EdgeInsets.all(10),
  //                 width: Responsive.w(44),
  //                 height: 110,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(22),
  //                   color: AppColors.skyblue,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(6.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       SvgPicture.asset("assets/images/Layer_1 (2).svg"),
  //                       SizedBox(height: Responsive.h(2)),
  //                       Text(
  //                         "Elec-magnetic Therapy",
  //                         textAlign: TextAlign.start,
  //                         style: GoogleFonts.teachers(
  //                           fontWeight: FontWeight.w400,
  //                           color: AppColors.primaryColor,
  //                           fontSize: Responsive.textScaleFactor * 12,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),

  //             GestureDetector(
  //               onTap:
  //                   () => Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (_) => OsteopathyView()),
  //                   ),
  //               // () =>
  //               //     Navigator.pushNamed(context, RoutesName.osteopathyview),
  //               child: Container(
  //                 padding: EdgeInsets.all(10),
  //                 width: Responsive.w(44),
  //                 height: 110,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(22),
  //                   color: AppColors.waterBlueColor,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(6.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       SvgPicture.asset("assets/images/Layer_1 (3).svg"),
  //                       SizedBox(height: Responsive.h(2)),
  //                       Text(
  //                         "Osteopathy",
  //                         textAlign: TextAlign.center,
  //                         style: GoogleFonts.teachers(
  //                           fontWeight: FontWeight.w400,
  //                           color: AppColors.primaryColor,
  //                           fontSize: Responsive.textScaleFactor * 12,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
