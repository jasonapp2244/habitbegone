import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/widgets/button.dart';

class MeMyselfProgramView extends StatelessWidget {
  const MeMyselfProgramView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              spacing: 10,
              children: [
                Image(image: AssetImage("assets/images/image 9.png")),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'The Choose to Lose: “Me, Myself & I Program”\n',
                        style: TextStyle(
                          color: const Color(0xFF1F49A7),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 1.45,
                        ),
                      ),
                      TextSpan(
                        text:
                            'For the truly independent spirit. This powerful online version is meticulously crafted for the self-help individual with the drive to succeed.\nIf you have the self-motivation and unwavering confidence in your ability to stay on track then this program is perfectly suited for you to embrace this very individual challenge.\nHere, youll gain complete control over your transformative journey. We provide all the essential tools, comprehensive digital tutorials, and powerful hypnotic sessions directly within the app, allowing you to seamlessly integrate the "Choose to Lose" methodology into your life on your own schedule, from anywhere. There iss no group obligation or one-on-one appointments; just you, the program, and your determination guiding you to unlock your full potential and achieve your ideal weight and well-being. This program is your personal blueprint for success, designed for those who prefer to be the sole architect of their own remarkable change.',
                        style: TextStyle(
                          color: const Color(0xFF1F49A7),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.81,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Timeline',
                      style: TextStyle(
                        color: const Color(0xFF1F49A7),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '1 Month',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xFF1F49A7),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pricing',
                      style: TextStyle(
                        color: const Color(0xFF1F49A7),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '\$250',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xFF1F49A7),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap:
                      () => Navigator.pushNamed(context, RoutesName.homeview),

                  child: Button(text: "Proceed to payment"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
