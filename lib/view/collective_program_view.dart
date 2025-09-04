import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/widgets/button.dart';

class CollectiveProgramView extends StatelessWidget {
  const CollectiveProgramView({super.key});

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
                        text: '"The to Lose: “Collective Program”',
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
                            'For shared strength and supportive progress. This version is specifically designed for individuals who thrive in a communal setting and respond best to the energy and encouragement of a small, dedicated group. You will join a dynamic collective of 4 to 6 like-minded adults, creating an intimate space where shared experiences foster growth and accountability.In "The Collective Program," you are not just a participant – you are an integral part of a supportive network. You will gain new insights, find mutual motivation, and break through challenges by both contributing your own wisdom and benefiting immensely from the diverse perspectives and dynamics of the group. Guided by a consultant, these interactive sessions provide structured support, shared encouragement, and a powerful sense of belonging, ensuring you stay on track and celebrate your journey to confidence and well-being, together.',
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
