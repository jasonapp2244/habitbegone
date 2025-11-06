import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:habitsbegone/view/auth/login_view.dart';
import 'package:habitsbegone/view/cousre_purchase/checkout.dart';
import 'package:habitsbegone/view/cousre_purchase/pay.dart';
import 'package:habitsbegone/view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set publishable key from Stripe dashboard (test key)
  Stripe.publishableKey =
      '';
  // Optionally set merchantIdentifier for Apple Pay, etc.
  // Stripe.merchantIdentifier = 'merchant.com.yourapp';

  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const HomeView(); // user logged in
          } else {
            return const LoginView(); // user not logged in
          }
        },
      ),
    );
    ;
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData) {
//             return const HomeView(); // user logged in
//           } else {
//             return const LoginView(); // user not logged in
//           }
//         },
//       ),
//     );
//     // GetMaterialApp(
//     //   debugShowCheckedModeBanner: false,
//     //   translations: Language(),

//     //   ///urdu language
//     //   // locale: Locale('ur','PK'),
//     //   locale: Locale('en', 'US'),
//     //   fallbackLocale: Locale('en', 'US'),
//     //   // home: HomeView(),
//     //   initialRoute: "/",
//     //   getPages: AppRoutes.appRoutes(),
//     // );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData) {
//             return const HomeScreen(); // user logged in
//           } else {
//             return const LoginScreen(); // user not logged in
//           }
//         },
//       ),
//     );
//   }
// }
