// lib/features/order_management/views/widgets/side_drawer_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Controller/order_management _controller.dart';

class SideDrawerWidget extends StatelessWidget {
  const SideDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderManagementController>();

    return Container(
      width: 250.w,
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: const BoxDecoration(
                color: Color(0xFF4A90E2),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      size: 20.sp,
                      color: const Color(0xFF4A90E2),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Squarepos',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Restaurant Management',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu items
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Orders menu item
                  _buildMenuItem(
                    icon: Icons.receipt_long,
                    title: 'ORDERS',
                    isSelected: true,
                    onTap: controller.navigateToOrders,
                  ),

                  SizedBox(height: 8.h),

                  // Settings menu item
                  _buildMenuItem(
                    icon: Icons.settings,
                    title: 'SETTINGS',
                    isSelected: false,
                    onTap: controller.navigateToSettings,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A90E2).withOpacity(0.1) : Colors.transparent,
          border: isSelected
              ? const Border(
            right: BorderSide(
              color: Color(0xFF4A90E2),
              width: 3,
            ),
          )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected ? const Color(0xFF4A90E2) : Colors.grey[600],
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF4A90E2) : Colors.grey[700],
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}