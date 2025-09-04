import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/widgets/button.dart';

class OneOnOneView extends StatelessWidget {
  const OneOnOneView({super.key});

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
                        text: '"The Choose to Lose: “One on One Program”',
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
                            'For ultimate personalized transformation and profound breakthroughs. This is our most exclusive and intensive offering, designed for clients who recognize the need for unparalleled individual support and specialized attention. In this One-on-One program, you receive the consultant is undivided focus, creating a completely confidential and highly responsive environment tailored solely to your journey.The cornerstone of this program is the power of customized Hypnosis sessions. Unlike pre-recorded sessions, these are crafted in real-time, precisely to your unique needs, specific triggers, underlying beliefs, and personal goals. This individual approach allows us to delve deeper, address long-standing patterns, and accelerate your progress toward a transformed relationship with food and your ideal weight. With the "One on One Program," you are investing in maximum impact, dedicated guidance, and the most direct path to lasting confidence and well-being.',
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
                  child: Button(text: "Proceed to payment")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
