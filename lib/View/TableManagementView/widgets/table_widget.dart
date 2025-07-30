// lib/features/table_management/views/widgets/table_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableWidget extends StatelessWidget {
  final Map<String, dynamic> table;
  final VoidCallback onTap;

  const TableWidget({
    super.key,
    required this.table,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = table['status'] == 'empty';
    final Color backgroundColor = isEmpty ? Colors.green[400]! : Colors.red[400]!;
    final String displayText = isEmpty ? '₹ 00' : '₹ ${table['price'].toInt()}';
    final String timerText = isEmpty ? '' : 'time:${table['timer']}';

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
              '${table['number']}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              displayText,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (!isEmpty) ...[
              SizedBox(height: 2.h),
              Text(
                timerText,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white70,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


