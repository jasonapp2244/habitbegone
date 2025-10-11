import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';

class ElecMagneticView extends StatefulWidget {
  const ElecMagneticView({super.key});

  @override
  State<ElecMagneticView> createState() => _ElecMagneticViewState();
}

class _ElecMagneticViewState extends State<ElecMagneticView> {
  File? _selectedFile;
  String? _uploadedFileUrl;
  bool _isUploading = false;

  Future<void> _pickAndUploadFile() async {
    try {
      // 1️⃣ Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4', 'pdf', 'doc', 'docx'],
      );

      if (result == null) return; // user canceled

      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;
      setState(() => _isUploading = true);

      // 2️⃣ Get current user info
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please log in first.')));
        return;
      }

      // 3️⃣ Upload to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child(
        'user_uploads/${user.uid}/$fileName',
      );
      await ref.putFile(file);

      final url = await ref.getDownloadURL();
      setState(() {
        _uploadedFileUrl = url;
        _selectedFile = file;
        _isUploading = false;
      });

      // 4️⃣ Save metadata to Firestore
      await FirebaseFirestore.instance.collection('user_uploads').add({
        'userId': user.uid,
        'email': user.email,
        'fileName': fileName,
        'fileUrl': url,
        'uploadedAt': FieldValue.serverTimestamp(),
        'type': result.files.single.extension,
        'category': 'ElecMagneticherapy',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File uploaded successfully!')),
      );
    } catch (e) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 10,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/Chevron Left.svg"),
                    const SizedBox(width: 10),
                    const Text(
                      'Elec-magnetic Therapy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Teachers',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.filledtextColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 5,
                        children: [
                          SvgPicture.asset("assets/icons/hypnotherapy.svg"),
                          const Text("Massage Therapy"),
                        ],
                      ),
                      SvgPicture.asset("assets/icons/ic_round-download.svg"),
                    ],
                  ),
                ),
              ),

              // 🟢 Upload Container
              InkWell(
                onTap: _isUploading ? null : _pickAndUploadFile,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColors.primaryColor,
                    border: Border.all(color: AppColors.filledtextColor),
                  ),
                  child: Center(
                    child:
                        _isUploading
                            ? const CircularProgressIndicator()
                            : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/upload.svg"),
                                const SizedBox(height: 8),
                                Text(
                                  _selectedFile == null
                                      ? 'Upload Form'
                                      : 'Selected: ${_selectedFile!.path.split('/').last}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
              ),

              const Spacer(),

              // 🟣 Submit Button
              InkWell(
                onTap: () {
                  if (_uploadedFileUrl != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Your file has been submitted successfully!',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please upload a file first.'),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.seconadryColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.67,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:habitsbegone/resources/colors/app_colors.dart';

// class ElecMagneticView extends StatelessWidget {
//   const ElecMagneticView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: SafeArea(
//         child: Column(
//           spacing: 10,
//           children: [
//             Row(
//               children: [
//                 SvgPicture.asset("assets/icons/Chevron Left.svg"),
//                 Text(
//                   'Elec-magnetic Therapy',
//                   style: GoogleFonts.teachers(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor,
//                 borderRadius: BorderRadius.circular(18),
//                 border: Border.all(color: AppColors.filledtextColor),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       spacing: 5,
//                       children: [
//                         SvgPicture.asset("assets/icons/hypnotherapy.svg"),
//                         Text("Elec-magnetic Therapy"),
//                       ],
//                     ),
//                     SvgPicture.asset("assets/icons/ic_round-download.svg"),
//                   ],
//                 ),
//               ),
//             ),

//             Container(
//               height: 150,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18),
//                 color: AppColors.primaryColor,
//                 border: Border.all(color: AppColors.filledtextColor),
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset("assets/icons/upload.svg"),
//                     Text(
//                       'Upload Form',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 10,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         height: 1.80,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Spacer(),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: AppColors.seconadryColor,
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Submit',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                         height: 1.67,
//                       ),
//                     ),
//                     SvgPicture.asset("assets/icons/Frame 12 (1).svg"),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
