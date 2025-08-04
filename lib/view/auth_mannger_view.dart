import 'package:flutter/material.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthManngerView extends StatelessWidget {
  const AuthManngerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          // assets/images/image 3.png
          children: [
            Image(image: AssetImage("assets/images/app_bar.png")),
            Text(
              "For More Information",
              textAlign: TextAlign.center,
              style: GoogleFonts.teachers(
                fontWeight: FontWeight.bold,
                color: AppColors.textBuleColor,
                fontSize: 16,
              ),
            ),
            Text(
              "eMail",
              textAlign: TextAlign.center,
              style: GoogleFonts.teachers(
                fontWeight: FontWeight.bold,
                color: AppColors.textBuleColor,
                fontSize: 16,
              ),
            ),
            Text(
              "Call",
              textAlign: TextAlign.center,
              style: GoogleFonts.teachers(
                fontWeight: FontWeight.bold,
                color: AppColors.textBuleColor,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Expanded(child: Divider(thickness: 4, color: AppColors.skyblue)),
              ],
            ),
            Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: AppColors.filledColor,
              ),
              child: Center(
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.teachers(
                    fontWeight: FontWeight.bold,
                    color: AppColors.filledtextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: AppColors.filledColor,
              ),
              child: Center(
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.teachers(
                    fontWeight: FontWeight.bold,
                    color: AppColors.filledtextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        
            Image(image: AssetImage("assets/images/image 3.png")),
          ],
        ),
      ),
    );
  }
}
