// lib/features/table_management/views/widgets/dish_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DishCardWidget extends StatelessWidget {
  final Map<String, dynamic> dish;
  final VoidCallback onTap;

  const DishCardWidget({
    super.key,
    required this.dish,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = dish['isSelected'] ?? false;
    final Color backgroundColor = isSelected ? Colors.green[400]! : Colors.grey[300]!;
    final Color textColor = isSelected ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.r,
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dish['name'],
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              '₹${dish['price'].toInt()}',
              style: TextStyle(
                fontSize: 11.sp,
                color: textColor.withOpacity(0.8),
              ),
            ),
            if (isSelected) ...[
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Qty: ${dish['quantity']}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
