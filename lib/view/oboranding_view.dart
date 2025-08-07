import 'package:flutter/material.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';
import 'package:getxmvvm/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OborandingView extends StatelessWidget {
  const OborandingView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return  LayoutBuilder(
          builder: (context, constraints) {
            return 
            
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// Profile Image
                      Image.asset(
                        "assets/images/profile.png",
                        width: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 20),

                      /// Intro Text
                      Text(
                        "Hi, I'm Gary Barone a Certified Hypnotist and I'm pleased to introduce you to HabitsBeGone.com.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dancingScript(
                          color: AppColors.textBuleColor,
                          fontSize: 28,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Description
                      Text(
                        "I've been helping people with various issues since 2011. And now I'd like to help you reach your Ideal Weight through our:",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.textBuleColor,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Topbar Image
                      Image.asset(
                        "assets/images/topbar.png",
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 20),

                      /// App Bar Image
                      Image.asset(
                        "assets/images/app_bar.png",
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          },
        
    );
  }
}
