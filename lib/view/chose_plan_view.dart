import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';

class ChosePlanView extends StatelessWidget {
  const ChosePlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 10,
              children: [
                Image(image: AssetImage("assets/images/image 9.png")),
                Text(
                  'Versions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F49A7),
                    fontSize: 25,
                    fontFamily: 'Teachers',
                    fontWeight: FontWeight.w600,
                    height: 1.24,
                  ),
                ),

                GestureDetector(
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        RoutesName.memyselfprogram,
                      ),

                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.filledtextColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'The Choose to Lose: “Me, Myself & I Program”\n',
                                  style: TextStyle(
                                    color: const Color(0xFF1F49A7),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 1.81,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'This powerful online version is made for the self-help individual whose self-motivation and confidence in their ability to stay on track allows them to take on this very individual challenge.',
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
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        RoutesName.collectiveProgram,
                      ),

                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.filledtextColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: ' The to Lose: “Collective Program”\n',
                                  style: TextStyle(
                                    color: const Color(0xFF1F49A7),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 1.81,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'This version is for those who react better with a group of 4 to 6 adults and who are adept contributing to group while also benefiting from the dynamics of the group.',
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
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:
                      () => Navigator.pushNamed(context, RoutesName.oneonone),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.filledtextColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      ' The Choose to Lose: “One on One Program”\n',
                                  style: TextStyle(
                                    color: const Color(0xFF1F49A7),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 1.81,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'This is an exclusive “one on one” version for clients with need of special attention with customized Hypnosis sessions.',
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
                        ],
                      ),
                    ),
                  ),
                ),

                Image(image: AssetImage("assets/images/app_bar.png")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
