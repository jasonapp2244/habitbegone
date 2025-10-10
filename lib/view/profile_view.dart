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
    final _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user?.uid;

    Future<void> _signOutUser(BuildContext context) async {
      // UserCredential userCredential = await _auth
      // After sign-out, navigate back to login
      await _firestore.collection('users').doc(uid).update({
        'uid': user?.uid,
        'email': user?.email,
        'isPaid': false,
        'isBlocked': false,
        'emailVerified': user?.emailVerified,
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
      body: SafeArea(
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
                    "Name : Albert Ford",
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
                    "Email : albertford@gmail.com",
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
                    "Active Subcribtion : Me, Myself & I Program",
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

                  ElevatedButton(
                    onPressed: () {
                      _signOutUser(context);
                    },
                    child: Text("data"),
                  ),
                ],
              ),

              Image(image: AssetImage("assets/images/image 7.png")),
            ],
          ),
        ),
      ),
    );
  }
}
