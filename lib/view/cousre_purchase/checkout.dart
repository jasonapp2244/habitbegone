// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// class CheckoutPage extends StatefulWidget {
//   final String courseId;
//   const CheckoutPage({super.key, required this.courseId});

//   @override
//   CheckoutPageState createState() => CheckoutPageState();
// }

// class CheckoutPageState extends State<CheckoutPage> {
//   bool loading = false;
//   Map<String, dynamic>? courseData;

//   @override
//   void initState() {
//     super.initState();
//     _fetchCourse();
//   }

//   Future<void> _fetchCourse() async {
//     final doc =
//         await FirebaseFirestore.instance
//             .collection('courses')
//             .doc(widget.courseId)
//             .get();
//     if (doc.exists) {
//       setState(() => courseData = doc.data());
//     }
//   }

//   Future<Map<String, dynamic>> _createPaymentIntent(String courseId) async {
//     final url = Uri.parse(
//       'https://createpaymentintent-jqoco5fmbq-uc.a.run.app',
//     );
//     final resp = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'courseId': courseId}),
//     );
//     return jsonDecode(resp.body);
//   }

//   Future<void> pay() async {
//     if (courseData == null) return;

//     setState(() => loading = true);
//     try {
//       final paymentData = await _createPaymentIntent(widget.courseId);
//       final clientSecret = paymentData['clientSecret'];

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: 'HabitBeGone',
//         ),
//       );

//       await Stripe.instance.presentPaymentSheet();
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text("Please sign in first")));
//         return;
//       }
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUser.uid)
//           .collection('purchases')
//           .doc(widget.courseId) // e.g., category name or course ID
//           .set({
//             'courseId': widget.courseId,
//             'purchasedAt': FieldValue.serverTimestamp(),
//             // 'amount': amount,
//           });

//       // await FirebaseFirestore.instance
//       //     .collection('users')
//       //     .doc(currentUser.uid)
//       //     .collection('purchases')
//       //     .doc(widget.courseId)
//       //     .update({
//       //       'courseId': widget.courseId,
//       //       'purchasedAt': FieldValue.serverTimestamp(),
//       //     });

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Payment complete!')));
//     } catch (e) {
//       print('Payment error: $e');
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Payment failed: $e')));
//     } finally {
//       setState(() => loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (courseData == null) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text(courseData!['name'] ?? "No Title")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: loading ? null : pay,
//           child:
//               loading
//                   ? const CircularProgressIndicator()
//                   : Text(
//                     'Pay \$${(courseData!['price'] / 100).toStringAsFixed(2)}',
//                   ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  final String courseId;
  const CheckoutPage({super.key, required this.courseId});

  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  bool loading = false;
  Map<String, dynamic>? courseData;

  @override
  void initState() {
    super.initState();
    _fetchCourse();
  }

  Future<void> _fetchCourse() async {
    final doc =
        await FirebaseFirestore.instance
            .collection('courses')
            .doc(widget.courseId)
            .get();

    if (doc.exists) {
      setState(() => courseData = doc.data());
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(String courseId) async {
    final url = Uri.parse(
      'https://createpaymentintent-jqoco5fmbq-uc.a.run.app',
    );
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'courseId': courseId}),
    );
    return jsonDecode(resp.body);
  }

  Future<void> pay() async {
    if (courseData == null) return;
    setState(() => loading = true);

    try {
      final paymentData = await _createPaymentIntent(widget.courseId);
      final clientSecret = paymentData['clientSecret'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'HabitBeGone',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please sign in first")));
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('purchases')
          .doc(widget.courseId)
          .set({
            'courseId': widget.courseId,
            'purchasedAt': FieldValue.serverTimestamp(),
          });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Payment complete!')));
      Navigator.pop(context, true);
    } catch (e) {
      debugPrint('Payment error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Payment failed: $e')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (courseData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final price = courseData!['price'];
    return Scaffold(
      appBar: AppBar(title: Text(courseData!['name'] ?? "Course")),
      body: Center(
        child: ElevatedButton(
          onPressed: loading ? null : pay,
          child:
              loading
                  ? const CircularProgressIndicator()
                  : Text('Pay \$${(price / 100).toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}
