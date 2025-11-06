import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';

class SupportUploadView extends StatefulWidget {
  final String courseId;
  final String courseName;

  const SupportUploadView({
    Key? key,
    required this.courseId,
    required this.courseName,
  }) : super(key: key);

  @override
  State<SupportUploadView> createState() => _SupportUploadViewState();
}

class _SupportUploadViewState extends State<SupportUploadView> {
  File? _selectedFile;
  String? _uploadedFileUrl;
  bool _isUploading = false;
  final TextEditingController _messageController = TextEditingController();

  Future<void> _pickAndUploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4', 'pdf', 'doc', 'docx'],
      );

      if (result == null) return;

      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;

      setState(() => _isUploading = true);

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in first.')),
        );
        return;
      }

      // 🔹 Upload to Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('course_support/${widget.courseId}/${user.uid}/$fileName');

      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      setState(() {
        _uploadedFileUrl = url;
        _selectedFile = file;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File uploaded successfully!')),
      );
    } catch (e) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }

  Future<void> _submitSupport() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in first.')),
      );
      return;
    }

    if (_uploadedFileUrl == null && _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a file or write a message.')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('course_support').add({
      'userId': user.uid,
      'email': user.email,
      'courseId': widget.courseId,
      'courseName': widget.courseName,
      'fileUrl': _uploadedFileUrl,
      'message': _messageController.text.trim(),
      'submittedAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Support request submitted successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 Header
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/Chevron Left.svg"),
                    const SizedBox(width: 10),
                    Text(
                      widget.courseName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Teachers',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 📝 Text Message Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  border: Border.all(color: AppColors.filledtextColor),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Write your message or concern...",
                    border: InputBorder.none,
                  ),
                ),
              ),

              // 📎 Upload File Section
              InkWell(
                onTap: _isUploading ? null : _pickAndUploadFile,
                child: Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColors.primaryColor,
                    border: Border.all(color: AppColors.filledtextColor),
                  ),
                  child: Center(
                    child: _isUploading
                        ? const CircularProgressIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/upload.svg"),
                              const SizedBox(height: 8),
                              Text(
                                _selectedFile == null
                                    ? 'Upload Image / Video / Document'
                                    : 'Selected: ${_selectedFile!.path.split('/').last}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
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

              // ✅ Submit Button
              InkWell(
                onTap: _submitSupport,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.seconadryColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
