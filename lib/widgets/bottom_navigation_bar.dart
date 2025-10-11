import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For SVG support
import 'package:habitsbegone/resources/colors/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildNavItem(
              assetPath: 'assets/icons/home.svg',
              index: 0,
              isSelected: widget.currentIndex == 0,
            ),
          ),
          Expanded(
            child: _buildNavItem(
              assetPath: 'assets/icons/mdi_planner.svg',
              index: 1,
              isSelected: widget.currentIndex == 1,
            ),
          ),
          Expanded(
            child: _buildNavItem(
              assetPath: 'assets/icons/profile.svg',
              index: 2,
              isSelected: widget.currentIndex == 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String assetPath,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => widget.onTap(index),

      child: Container(
        color: AppColors.primaryColor,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              assetPath,
              color:
                  isSelected
                      ? AppColors.textColorBlack
                      : AppColors.filledtextColor,
              height: 24,
              width: 24,
            ),
            SizedBox(height: 4),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.textColorBlack : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
