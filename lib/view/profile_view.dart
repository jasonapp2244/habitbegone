import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/view/auth/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    // final _auth = FirebaseAuth.instance;
    final currentUser = FirebaseAuth.instance.currentUser;

    // final User? user = _auth.currentUser;
    final uid = currentUser?.uid;
    if (currentUser == null) {
      return const Center(
        child: Text(
          'No user logged in',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Teachers',
            fontWeight: FontWeight.w500,
            height: 1.40,
          ),
        ),
      );
    }
    final userDoc =
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .snapshots();
    Future<void> _signOutUser(BuildContext context) async {
      // UserCredential userCredential = await _auth
      // After sign-out, navigate back to login
      await _firestore.collection('users').doc(uid).update({
        'uid': currentUser.uid,
        'email': currentUser.email,
        'isPaid': false,
        'isBlocked': false,
        'emailVerified': currentUser.emailVerified,
        'lastOnline': FieldValue.serverTimestamp(),
      });
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false, // remove all previous routes
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: StreamBuilder<DocumentSnapshot>(
        stream: userDoc,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!asyncSnapshot.hasData || !asyncSnapshot.data!.exists) {
            return const Center(child: Text('User data not found'));
          }

          final userData = asyncSnapshot.data!.data() as Map<String, dynamic>;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(image: AssetImage("assets/images/image 3.png")),

                  Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Name: ${userData['name']}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Teachers',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Email: ${userData['email']}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Teachers',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Age: ${userData['isPaid']}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Teachers',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: const Color(0xFF0A3B7C),
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'For More Information',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF0A3B7C),
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'eMail',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF0A3B7C),
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Call',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF0A3B7C),
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _signOutUser(context);
                        },
                        child: Text(
                          'Log Out',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 204, 10, 10),
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     _signOutUser(context);
                      //   },
                      //   child:  Text(
                      //   'Call',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: const Color(0xFF0A3B7C),
                      //     fontSize: 18,
                      //     fontFamily: 'Inter',
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),,
                      // ),
                    ],
                  ),

                  Image(image: AssetImage("assets/images/image 7.png")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
