import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/utils/responsive.dart';
import 'package:habitsbegone/view/video_player.dart';
import 'package:open_filex/open_filex.dart';

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

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text("Please sign in to view your courses")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("My Courses"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // 👇 Fetch from the new subcollection
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('purchases')
            .orderBy('purchasedAt', descending: true)
            .snapshots(),
        builder: (context, purchaseSnapshot) {
          if (!purchaseSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final purchases = purchaseSnapshot.data!.docs;

          if (purchases.isEmpty) {
            return const Center(
              child: Text("You haven’t purchased any courses yet."),
            );
          }

          return ListView.builder(
            itemCount: purchases.length,
            itemBuilder: (context, index) {
              final courseId = purchases[index]['courseId'];
              return _buildCourseSection(courseId);
            },
          );
        },
      ),
    );
  }

  Widget _buildCourseSection(String courseId) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId)
          .snapshots(),
      builder: (context, courseSnap) {
        if (!courseSnap.hasData) {
          return const SizedBox.shrink();
        }

        final courseData = courseSnap.data!.data() as Map<String, dynamic>?;
        if (courseData == null) return const SizedBox.shrink();

        return ExpansionTile(
          title: Text(
            courseData['name'] ?? courseId,
            style: GoogleFonts.teachers(
              fontSize: Responsive.textScaleFactor * 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textColorBlack,
            ),
          ),
          subtitle: Text(
            "Purchased course",
            style: const TextStyle(color: Colors.grey),
          ),
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
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
                  children: lessons.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final title = data['title'] ?? 'Untitled';
                    final desc = data['description'] ?? '';
                    final files =
                        List<Map<String, dynamic>>.from(data['files'] ?? []);

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: ExpansionTile(
                        title: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(desc),
                        children: files.map((file) {
                          final fileUrl = file['url'] ?? '';
                          final fileType = file['type'] ?? '';

                          return ListTile(
                            leading: Icon(
                              fileType == 'video'
                                  ? Icons.videocam
                                  : fileType == 'image'
                                      ? Icons.image
                                      : Icons.picture_as_pdf,
                              color: fileType == 'document'
                                  ? Colors.red
                                  : (fileType == 'video'
                                      ? Colors.blue
                                      : Colors.green),
                            ),
                            title: Text(fileUrl.split('/').last),
                            onTap: () {
                              if (fileType == 'video') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VideoPlayerScreen(
                                      videoUrl: fileUrl,
                                    ),
                                  ),
                                );
                              } else if (fileType == 'image') {
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    child: Image.network(fileUrl),
                                  ),
                                );
                              } else if (fileType == 'document') {
                                OpenFilex.open(fileUrl);
                              }
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}






























// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:habitsbegone/resources/colors/app_colors.dart';
// import 'package:habitsbegone/utils/responsive.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:habitsbegone/view/video_player.dart';
// import 'package:open_filex/open_filex.dart'; // for opening PDFs or documents

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
//           stream:
//               FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(userId)
//                   .snapshots(),
//           builder: (context, userSnap) {
//             if (!userSnap.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final data = userSnap.data!.data() as Map<String, dynamic>?;
//             final purchased = List<String>.from(
//               data?['purchasedCourses'] ?? [],
//             );

//             if (purchased.isEmpty) {
//               return const Center(
//                 child: Text("You haven’t purchased any courses yet."),
//               );
//             }

//             final validCourses =
//                 purchased.where((c) => c.trim().isNotEmpty).toList();

//             return ListView.builder(
//               itemCount: validCourses.length,
//               itemBuilder: (context, index) {
//                 final courseId = validCourses[index];
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
//         courseId.replaceAll('_', ' ').toUpperCase(),
//         style: GoogleFonts.teachers(
//           fontSize: Responsive.textScaleFactor * 20,
//           fontWeight: FontWeight.w700,
//           color: AppColors.textColorBlack,
//         ),
//       ),
//       children: [
//         StreamBuilder<QuerySnapshot>(
//           stream:
//               FirebaseFirestore.instance
//                   .collection('courses')
//                   .doc(courseId.toLowerCase().replaceAll(' ', '_'))
//                   .collection('lessons')
//                   .orderBy('uploadedAt', descending: false)
//                   .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: CircularProgressIndicator(),
//               );
//             }

//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text("No lessons available yet."),
//               );
//             }

//             final lessons = snapshot.data!.docs;

//             return Column(
//               children:
//                   lessons.map((doc) {
//                     final data = doc.data() as Map<String, dynamic>;
//                     final title = data['title'] ?? 'Untitled';
//                     final desc = data['description'] ?? '';
//                     final files = List<Map<String, dynamic>>.from(
//                       data['files'] ?? [],
//                     );

//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 3,
//                       child: ExpansionTile(
//                         title: Text(
//                           title,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(desc),
//                         children:
//                             files.map((file) {
//                               final fileUrl = file['url'] ?? '';
//                               final fileType = file['type'] ?? '';
//                               print(fileType);
//                               print(fileUrl);

//                               return ListTile(
//                                 leading: Icon(
//                                   fileType == 'video'
//                                       ? Icons.videocam
//                                       : fileType == 'image'
//                                       ? Icons.image
//                                       : Icons.picture_as_pdf,
//                                   color:
//                                       fileType == 'document'
//                                           ? Colors.red
//                                           : (fileType == 'video'
//                                               ? Colors.blue
//                                               : Colors.green),
//                                 ),
//                                 title: Text(fileUrl.split('/').last),
//                                 onTap: () {
//                                   print(fileType);
//                                   print(fileUrl);
//                                   if (fileType == 'video') {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder:
//                                             (_) => VideoPlayerScreen(
//                                               videoUrl: fileUrl,
//                                             ),
//                                       ),
//                                     );
//                                   } else if (fileType == 'image') {
//                                     showDialog(
//                                       context: context,
//                                       builder:
//                                           (_) => Dialog(
//                                             child: Image.network(fileUrl),
//                                           ),
//                                     );
//                                   } else if (fileType == 'document') {
//                                     // You can open PDF in web or device viewer
//                                     OpenFilex.open(fileUrl);
//                                   }
//                                 },
//                               );
//                             }).toList(),
//                       ),
//                     );
//                   }).toList(),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
