import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';
import 'package:getxmvvm/utils/responsive.dart';
import 'package:getxmvvm/widgets/bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(child: _getBodyContent()),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }

  Widget _getBodyContent() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return _buildSearchContent();
      case 2:
        return _buildProfileContent();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change Your Life with",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.teachers(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColorBlack,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "Hypnosis!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.teachers(
                      fontWeight: FontWeight.w400,
                      color: AppColors.skyblue,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset("assets/images/Frame 27.svg"),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: Responsive.w(45),
                height: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: AppColors.textBuleColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/Layer_1 (1).svg"),
                      SizedBox(height: 20),
                      Text(
                        "Hypnotherapy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.teachers(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                          fontSize: Responsive.textScaleFactor * 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: Responsive.w(45),
                height: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: AppColors.skyblue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/Layer_1 (2).svg"),
                      SizedBox(height: 20),
                      Text(
                        "Elec-magnetic Therapy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.teachers(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontSize: Responsive.textScaleFactor * 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: Responsive.w(45),
                height: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: AppColors.textBuleColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/Layer_1 (4).svg"),
                      SizedBox(height: 20),
                      Text(
                        "Osteopathy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.teachers(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                          fontSize: Responsive.textScaleFactor * 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: Responsive.w(45),
                height: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: AppColors.skyblue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/Layer_1 (3).svg"),
                      SizedBox(height: 20),
                      Text(
                        "Osteopathy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.teachers(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontSize: Responsive.textScaleFactor * 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Search",
            style: GoogleFonts.teachers(
              fontWeight: FontWeight.w500,
              color: AppColors.textColorBlack,
              fontSize: 32,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for treatments...",
                border: InputBorder.none,
                icon: Icon(Icons.search, color: AppColors.filledtextColor),
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 64,
                    color: AppColors.filledtextColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Start searching for treatments",
                    style: GoogleFonts.teachers(
                      fontWeight: FontWeight.w400,
                      color: AppColors.filledtextColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Profile",
            style: GoogleFonts.teachers(
              fontWeight: FontWeight.w500,
              color: AppColors.textColorBlack,
              fontSize: 32,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.skyblue,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "John Doe",
                  style: GoogleFonts.teachers(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColorBlack,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "johndoe@example.com",
                  style: GoogleFonts.teachers(
                    fontWeight: FontWeight.w400,
                    color: AppColors.filledtextColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
