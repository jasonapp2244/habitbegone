// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/models.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Square Payment Demo',
//       home: PaymentPage(),
//     );
//   }
// }

// class PaymentPage extends StatelessWidget {
//   const PaymentPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     InAppPayments.setSquareApplicationId(
//       'YOUR_SQUARE_APPLICATION_ID', // Sandbox/Production ID
//     );

//     Future<void> _pay() async {
//       try {
//         await InAppPayments.startCardEntryFlow(
//           onCardNonceRequestSuccess: (CardDetails result) async {
//             final nonce = result.nonce;
//             print("Got nonce: $nonce");

//             try {
//               // Call Firebase Cloud Function to process payment
//               final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('processSquarePayment');
//               final response = await callable.call({
//                 'nonce': nonce,
//                 'amount': 1000, // in cents, e.g. 1000 = $10.00
//                 'currency': 'USD'
//               });

//               print("Payment success: ${response.data}");
//               InAppPayments.completeCardEntry(onCardEntryComplete: () {
//                 print("Payment complete");
//               });
//             } catch (e) {
//               print("Payment failed: $e");
//               InAppPayments.showCardNonceProcessingError("Payment failed");
//             }
//           },
//           onCardEntryCancel: () {
//             print("Payment canceled");
//           },
//         );
//       } catch (e) {
//         print("Error: $e");
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text("Square Payment")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _pay,
//           child: const Text("Pay with Square"),
//         ),
//       ),
//     );
//   }
// }
