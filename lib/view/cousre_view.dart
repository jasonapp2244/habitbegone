import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/utils/responsive.dart';
import 'package:habitsbegone/widgets/cousre_content_widget.dart';

class MyTakenCousreView extends StatefulWidget {
  const MyTakenCousreView({super.key});

  @override
  State<MyTakenCousreView> createState() => _MyTakenCousreViewState();
}

class _MyTakenCousreViewState extends State<MyTakenCousreView> {
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 2,
                      children: [
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //   },
                        //   child: SvgPicture.asset(
                        //     "assets/icons/Arrow - Right 3.svg",
                        //   ),
                        // ),
                        SizedBox(width: Responsive.w(1)),
                        Text(
                          'Collective Program',
                          style: GoogleFonts.teachers(
                            color: AppColors.textColorBlack,
                            fontSize: Responsive.textScaleFactor * 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.20,
                          ),
                        ),
                      ],
                    ),
                    // circularIcon("assets/icons/robotic.svg"),
                  ],
                ),
                CourseContentWidget(),
                CourseContentWidget(),
                CourseContentWidget(),
                CourseContentWidget(),
                CourseContentWidget(),
                // GestureDetector(
                //   onTap: () => _courseCompleteAlert(context),
                //   child: Container(
                //     width: double.infinity,
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 18,
                //       vertical: 8,
                //     ),
                //     decoration: ShapeDecoration(
                //       color: AppColors.seconadryColor,
                //       shape: RoundedRectangleBorder(
                //         side: BorderSide(width: 1, color: Colors.red),
                //         borderRadius: BorderRadius.circular(40),
                //       ),
                //     ),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       spacing: 8,
                //       children: [
                //         Text(
                //           'Mark As Completed',
                //           textAlign: TextAlign.center,
                //           style: GoogleFonts.dmSans(
                //             color: AppColors.primaryColor,
                //             fontSize: Responsive.textScaleFactor * 14,
                //             fontWeight: FontWeight.w500,
                //             letterSpacing: -0.20,
                //           ),
                //         ),
                //         SvgPicture.asset("assets/icons/vector.svg"),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _courseCompleteAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/icons/checkmark-circle-02.svg"),
              SizedBox(height: Responsive.h(1)),
              Text(
                "Congratulations!",
                style: TextStyle(
                  color: AppColors.textBuleColor,
                  fontSize: Responsive.textScaleFactor * 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Responsive.h(1)),
              Text(
                "You’ve made great progress. Your certificate is ready for download and you can now showcase your achievement!",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: Responsive.textScaleFactor * 16,
                ),
              ),
              SizedBox(height: Responsive.h(5)),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  // Utils.toastMassage("Session booked Successful");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: AppColors.seconadryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Got It",
                            style: GoogleFonts.dmSans(
                              fontSize: Responsive.textScaleFactor * 14,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SvgPicture.asset("assets/icons/arrow.svg"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget circularIcon(String image) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.20)),
      shape: BoxShape.circle,
      // color: AppColor.white.withValues(alpha: 0.01),
    ),
    child: Padding(
      padding: Responsive.padding(top: 3, bottom: 3, right: 3, left: 3),
      child: Center(child: SvgPicture.asset(image)),
    ),
  );
}
