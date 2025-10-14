import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitsbegone/view/video_player.dart';
import 'package:habitsbegone/widgets/lesson_tile.dart';

class MyTakenCourseView extends StatefulWidget {
  const MyTakenCourseView({super.key});

  @override
  State<MyTakenCourseView> createState() => _MyTakenCourseViewState();
}

class _MyTakenCourseViewState extends State<MyTakenCourseView> {
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    if (userId == null) return const Center(child: Text("Not logged in"));

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .snapshots(),
          builder: (context, userSnap) {
            if (!userSnap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = userSnap.data!.data() as Map<String, dynamic>?;
            final purchased = List<String>.from(
              data?['purchasedCourses'] ?? [],
            );

            if (purchased.isEmpty) {
              return const Center(
                child: Text("You haven’t purchased any courses yet."),
              );
            }

            // Filter out null or empty course IDs
            final validCourses =
                purchased.where((c) => c.trim().isNotEmpty).toList();

            return ListView.builder(
              itemCount: validCourses.length,
              itemBuilder: (context, index) {
                final courseId = validCourses[index];
                return _buildCourseSection(courseId);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCourseSection(String courseId) {
    return ExpansionTile(
      title: Text(
        courseId.replaceAll('_', ' ').toUpperCase(),
        style: GoogleFonts.teachers(
          fontSize: Responsive.textScaleFactor * 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textColorBlack,
        ),
      ),
      children: [
        StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection('courses')
                  .doc(courseId)
                  .collection('lessons')
                  .orderBy('uploadedAt', descending: false)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No lessons available yet."),
              );
            }

            final lessons = snapshot.data!.docs;

            return Column(
              children:
                  lessons.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final title = data['title'] ?? 'Untitled';
                    final desc = data['description'] ?? '';
                    final fileUrl = data['fileUrl'] ?? '';
                    final fileType = data['fileType'] ?? '';
                    final uploadedAt = data['uploadedAt'];
                    final date =
                        uploadedAt is Timestamp ? uploadedAt.toDate() : null;

                    return LessonTile(
                      title: title,
                      description: desc,
                      fileType: fileType,
                      fileUrl: fileUrl,
                      onOpen: () {
                        if (fileType == 'video') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => VideoPlayerScreen(videoUrl: fileUrl),
                            ),
                          );
                        } else if (fileType == 'image') {
                          showDialog(
                            context: context,
                            builder:
                                (_) => Dialog(child: Image.network(fileUrl)),
                          );
                        } else if (fileType == 'document') {
                          // Open PDF viewer (can use flutter_pdfview or open_filex)
                        }
                      },
                    );
                    // ListTile(
                    //   title: Text(title),
                      // subtitle: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(desc),
                      //     if (date != null)
                      //       Text(
                      //         "Uploaded: ${date.toLocal()}",
                      //         style: const TextStyle(
                      //           fontSize: 12,
                      //           color: Colors.grey,
                      //         ),
                      //       ),
                      //   ],
                      // ),
                    //   trailing: IconButton(
                    //     icon: const Icon(Icons.open_in_new),
                    //     onPressed: () {
                    //       if (fileType == 'video') {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder:
                    //                 (_) => VideoPlayerScreen(videoUrl: fileUrl),
                    //           ),
                    //         );
                    //       } else if (fileType == 'image') {
                    //         showDialog(
                    //           context: context,
                    //           builder:
                    //               (_) => Dialog(child: Image.network(fileUrl)),
                    //         );
                    //       } else if (fileType == 'document') {
                    //         // TODO: open PDF viewer
                    //       }
                    //     },
                    //   ),
                    // );
                  }).toList(),
            );
          },
        ),
      ],
    );
  }
}






















// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:habitsbegone/resources/colors/app_colors.dart';
// import 'package:habitsbegone/utils/responsive.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class MyTakenCourseView extends StatefulWidget {
//   const MyTakenCourseView({super.key});

//   @override
//   State<MyTakenCourseView> createState() => _MyTakenCourseViewState();
// }

// class _MyTakenCourseViewState extends State<MyTakenCourseView> {
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     userId = FirebaseAuth.instance.currentUser?.uid;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);
//     if (userId == null) return const Center(child: Text("Not logged in"));

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.primaryColor,
//         body: StreamBuilder<DocumentSnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('users')
//               .doc(userId)
//               .snapshots(),
//           builder: (context, userSnap) {
//             if (!userSnap.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final data = userSnap.data!.data() as Map<String, dynamic>?;
//             final purchased = List<String>.from(data?['purchasedCourses'] ?? []);

//             if (purchased.isEmpty) {
//               return const Center(
//                   child: Text("You haven’t purchased any courses yet."));
//             }

//             return ListView.builder(
//               itemCount: purchased.length,
//               itemBuilder: (context, index) {
//                 final courseId = purchased[index];
//                 return _buildCourseSection(courseId);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildCourseSection(String courseId) {
//     return ExpansionTile(
//       title: Text(
//         courseId.toUpperCase(),
//         style: GoogleFonts.teachers(
//           fontSize: Responsive.textScaleFactor * 20,
//           fontWeight: FontWeight.w700,
//           color: AppColors.textColorBlack,
//         ),
//       ),
//       children: [
//         StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('courses')
//               .doc(courseId)
//               .collection('lessons')
//               .orderBy('uploadedAt', descending: false)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: CircularProgressIndicator(),
//               );
//             }

//             final lessons = snapshot.data!.docs;

//             if (lessons.isEmpty) {
//               return const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text("No lessons available yet."),
//               );
//             }

//             return Column(
//               children: lessons.map((doc) {
//                 final data = doc.data() as Map<String, dynamic>;
//                 final title = data['title'] ?? '';
//                 final desc = data['description'] ?? '';
//                 final fileUrl = data['fileUrl'] ?? '';
//                 final fileType = data['fileType'] ?? '';

//                 return ListTile(
//                   title: Text(title),
//                   subtitle: Text(desc),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.open_in_new),
//                     onPressed: () {
//                       if (fileType == 'video') {
//                         // open video player screen
//                       } else if (fileType == 'image') {
//                         showDialog(
//                           context: context,
//                           builder: (_) => Dialog(
//                             child: Image.network(fileUrl),
//                           ),
//                         );
//                       } else if (fileType == 'document') {
//                         // open PDF viewer
//                       }
//                     },
//                   ),
//                 );
//               }).toList(),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
















// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:habitsbegone/resources/colors/app_colors.dart';
// // import 'package:habitsbegone/utils/responsive.dart';
// // import 'package:habitsbegone/widgets/cousre_content_widget.dart';

// // class MyTakenCousreView extends StatefulWidget {
// //   const MyTakenCousreView({super.key});

// //   @override
// //   State<MyTakenCousreView> createState() => _MyTakenCousreViewState();
// // }

// // class _MyTakenCousreViewState extends State<MyTakenCousreView> {
// //   @override
// //   Widget build(BuildContext context) {
// //     Responsive.init(context);
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: AppColors.primaryColor,
// //         body: ListView(
// //           children: [
// //             Column(
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Row(
// //                       spacing: 2,
// //                       children: [
// //                         SizedBox(width: Responsive.w(1)),
// //                         Text(
// //                           'Collective Program',
// //                           style: GoogleFonts.teachers(
// //                             color: AppColors.textColorBlack,
// //                             fontSize: Responsive.textScaleFactor * 22,
// //                             fontWeight: FontWeight.w600,
// //                             letterSpacing: -0.20,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //                 CourseContentWidget(),
// //                 CourseContentWidget(),
// //                 CourseContentWidget(),
// //                 CourseContentWidget(),
// //                 CourseContentWidget(),
// //                 GestureDetector(
// //                   onTap: () => _courseCompleteAlert(context),
// //                   child: Container(
// //                     width: double.infinity,
// //                     padding: const EdgeInsets.symmetric(
// //                       horizontal: 18,
// //                       vertical: 8,
// //                     ),
// //                     decoration: ShapeDecoration(
// //                       color: AppColors.seconadryColor,
// //                       shape: RoundedRectangleBorder(
// //                         side: BorderSide(width: 1, color: Colors.red),
// //                         borderRadius: BorderRadius.circular(40),
// //                       ),
// //                     ),
// //                     child: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       spacing: 8,
// //                       children: [
// //                         Text(
// //                           'Mark As Completed',
// //                           textAlign: TextAlign.center,
// //                           style: GoogleFonts.dmSans(
// //                             color: AppColors.primaryColor,
// //                             fontSize: Responsive.textScaleFactor * 14,
// //                             fontWeight: FontWeight.w500,
// //                             letterSpacing: -0.20,
// //                           ),
// //                         ),
// //                         SvgPicture.asset("assets/icons/vector.svg"),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // void _courseCompleteAlert(BuildContext context) {
// //   showDialog(
// //     context: context,
// //     barrierDismissible: false,
// //     builder: (BuildContext context) {
// //       return Dialog(
// //         backgroundColor: AppColors.primaryColor,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(20.0),
// //         ),
// //         child: Padding(
// //           padding: EdgeInsets.all(20.0),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               SvgPicture.asset("assets/icons/checkmark-circle-02.svg"),
// //               SizedBox(height: Responsive.h(1)),
// //               Text(
// //                 "Congratulations!",
// //                 style: TextStyle(
// //                   color: AppColors.textBuleColor,
// //                   fontSize: Responsive.textScaleFactor * 20,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(height: Responsive.h(1)),
// //               Text(
// //                 "You’ve made great progress. Your certificate is ready for download and you can now showcase your achievement!",
// //                 style: TextStyle(
// //                   color: AppColors.primaryColor,
// //                   fontSize: Responsive.textScaleFactor * 16,
// //                 ),
// //               ),
// //               SizedBox(height: Responsive.h(5)),

// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.of(context).pop();
// //                   Navigator.of(context).pop();
// //                   // Utils.toastMassage("Session booked Successful");
// //                 },
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(28),
// //                     color: AppColors.seconadryColor,
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.symmetric(
// //                       vertical: 8.0,
// //                       horizontal: 16.0,
// //                     ),
// //                     child: Center(
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         crossAxisAlignment: CrossAxisAlignment.center,
// //                         children: [
// //                           Text(
// //                             "Got It",
// //                             style: GoogleFonts.dmSans(
// //                               fontSize: Responsive.textScaleFactor * 14,
// //                               color: AppColors.primaryColor,
// //                               fontWeight: FontWeight.w700,
// //                             ),
// //                           ),
// //                           SvgPicture.asset("assets/icons/arrow.svg"),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     },
// //   );
// // }

// // Widget circularIcon(String image) {
// //   return Container(
// //     decoration: BoxDecoration(
// //       border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.20)),
// //       shape: BoxShape.circle,
// //       // color: AppColor.white.withValues(alpha: 0.01),
// //     ),
// //     child: Padding(
// //       padding: Responsive.padding(top: 3, bottom: 3, right: 3, left: 3),
// //       child: Center(child: SvgPicture.asset(image)),
// //     ),
// //   );
// // }
