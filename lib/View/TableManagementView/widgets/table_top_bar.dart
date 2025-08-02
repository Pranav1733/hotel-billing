import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableTopBar extends StatelessWidget {
  final VoidCallback onTakeOrders;
  final VoidCallback onReadyOrders;

  const TableTopBar({
    super.key,
    required this.onTakeOrders,
    required this.onReadyOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onTakeOrders,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Text('take orders', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: OutlinedButton(
              onPressed: onReadyOrders,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Text('ready orders', style: TextStyle(color: Colors.black, fontSize: 16.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
