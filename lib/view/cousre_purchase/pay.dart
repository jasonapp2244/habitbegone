import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/view/cousre_purchase/checkout.dart';

class BuyCourseView extends StatelessWidget {
  const BuyCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Buy Your Plan"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('courses').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());

                final courses = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final data = courses[index].data() as Map<String, dynamic>;
                    final courseId = courses[index].id;

                    return ListTile(
                      title: Text(data['name'] ?? 'Unnamed Course'),
                      subtitle: Text(
                        data['price'] != null
                            ? "\$${(data['price'] / 100).toStringAsFixed(2)}"
                            : "Price not available",
                      ),
                      trailing: StreamBuilder<DocumentSnapshot>(
                        stream:
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .collection('purchases')
                                .doc(courseId)
                                .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          }

                          final hasPurchased = snapshot.data!.exists;

                          if (hasPurchased) {
                            return const Text(
                              "✅ Purchased",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => CheckoutPage(courseId: courseId),
                                ),
                              );
                            },
                            child: const Text("Buy Now"),
                          );
                        },
                      ),

                      //  FutureBuilder<DocumentSnapshot>(
                      //   future:
                      //       FirebaseFirestore.instance
                      //           .collection('users')
                      //           .doc(userId)
                      //           .collection('purchases')
                      //           .doc(courseId)
                      //           .get(),
                      //   builder: (context, snapshot) {
                      //     if (!snapshot.hasData) {
                      //       return const SizedBox(
                      //         width: 24,
                      //         height: 24,
                      //         child: CircularProgressIndicator(strokeWidth: 2),
                      //       );
                      //     }

                      //     final hasPurchased = snapshot.data!.exists;

                      //     if (hasPurchased) {
                      //       return const Text(
                      //         "✅ Purchased",
                      //         style: TextStyle(
                      //           color: Colors.green,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       );
                      //     }

                      //     return ElevatedButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder:
                      //                 (_) => CheckoutPage(courseId: courseId),
                      //           ),
                      //         );
                      //       },
                      //       child: const Text("Buy Now"),
                      //     );
                      //   },
                      // ),
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
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:habitsbegone/resources/colors/app_colors.dart';
// import 'package:habitsbegone/view/cousre_purchase/checkout.dart';

// class BuyCousreView extends StatelessWidget {
//   const BuyCousreView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryColor,
//         title: Text("Buy A Your Plan"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection('courses').snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) return const CircularProgressIndicator();
//                 final courses = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: courses.length,
//                   itemBuilder: (context, index) {
//                     final data = courses[index].data() as Map<String, dynamic>;
//                     final courseId = courses[index].id;
//                     return ListTile(
//                       title: Text(data['name']),
//                       subtitle: Text(
//                         "\$${(data['price'] / 100).toStringAsFixed(2)}",
//                       ),
//                       trailing: ElevatedButton(
//                         onPressed:
//                             () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (_) => CheckoutPage(courseId: courseId),
//                               ),
//                             ),
//                         child: const Text("Buy"),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
