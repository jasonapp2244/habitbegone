import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/view/auth/login_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  // --- Helper functions for launching call/email ---
  Future<void> _callUser(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _emailUser(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello from HabitsBeGone!',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser?.uid;

    if (currentUser == null) {
      return const Center(child: Text('No user logged in'));
    }

    // 🔹 Your own user document (personal info)
    final userDoc = _firestore.collection('users').doc(uid).snapshots();

    // 🔹 The public app owner/contact info stored in "app_users"
    final adminContact =
        _firestore
            .collection('app_users')
            .doc('contact_info') // 👈 or whatever document ID you used
            .snapshots();

    Future<void> _signOutUser(BuildContext context) async {
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
        (route) => false,
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
          final name = userData['name'] ?? 'Unknown';
          final email = userData['email'] ?? '';

          // 👇 Nested StreamBuilder for the contact info
          return StreamBuilder<DocumentSnapshot>(
            stream: adminContact,
            builder: (context, contactSnapshot) {
              if (contactSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!contactSnapshot.hasData || !contactSnapshot.data!.exists) {
                return const Center(child: Text('Contact info not found'));
              }

              final contactData =
                  contactSnapshot.data!.data() as Map<String, dynamic>;
              final adminEmail = contactData['email'] ?? '';
              final adminPhone = contactData['phone'] ?? '';

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image: AssetImage("assets/images/image 3.png"),
                        ),

                        Column(
                          spacing: 10,
                          children: [
                            Text(
                              "Name: $name",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Teachers',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Email: $email",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Teachers',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(
                              color: Color(0xFF0A3B7C),
                              thickness: 2,
                            ),

                            const Text(
                              'For More Information',
                              style: TextStyle(
                                color: Color(0xFF0A3B7C),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),

                            // ✅ Email (from app_users)
                            TextButton(
                              onPressed:
                                  adminEmail.isNotEmpty
                                      ? () => _emailUser(adminEmail)
                                      : null,
                              child: const Text('Email'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF0A3B7C),
                              ),
                            ),
                            const SizedBox(height: 4),

                            // ✅ Phone (from app_users)
                            TextButton(
                              onPressed:
                                  adminEmail.isNotEmpty
                                      ? () => _callUser(adminPhone)
                                      : null,
                              child: const Text('Call'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF0A3B7C),
                              ),
                            ),

                            const SizedBox(height: 20),

                            TextButton(
                              onPressed: () => _signOutUser(context),
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 204, 10, 10),
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Image(
                          image: AssetImage("assets/images/image 7.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
