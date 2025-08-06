// lib/features/order_management/views/widgets/order_card_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Controller/order_management _controller.dart';

class OrderCardWidget extends StatelessWidget {
  final Map<String, dynamic> orderData;
  final bool isAcceptTab;

  const OrderCardWidget({
    super.key,
    required this.orderData,
    required this.isAcceptTab,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderManagementController>();

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),

          SizedBox(height: 16.h),

          // Customer details
          _buildCustomerDetails(),

          SizedBox(height: 16.h),

          // Action buttons
          _buildActionButtons(controller),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          orderData['orderNumber'] ?? 'Order',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Text(
              orderData['time'] ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              orderData['tableNumber'] ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'please enter your details',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 12.h),
        ...(_buildDetailItems()),
      ],
    );
  }

  List<Widget> _buildDetailItems() {
    final details = orderData['customerDetails'] as List<dynamic>? ?? [];

    return details.map((detail) {
      return Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                detail['value']?.isEmpty ?? true
                    ? detail['label'] ?? ''
                    : detail['value'],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: detail['value']?.isEmpty ?? true
                      ? Colors.grey[500]
                      : Colors.black,
                ),
              ),
            ),
            if ((detail['count'] as int? ?? 0) > 0)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '${detail['count']}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildActionButtons(OrderManagementController controller) {
    if (isAcceptTab) {
      // Accept/Reject buttons for pending orders
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.showCancelOrderModal(orderData['id']),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      size: 16.sp,
                      color: Colors.grey[700],
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Reject',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.acceptOrder(orderData['id']),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Accept',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // Preparing/Mark as Done buttons for completed orders
      final status = orderData['status'] ?? '';

      return Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: status == 'completed' ? Colors.grey[300] : Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Text(
                'Preparing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: status == 'completed' ? Colors.grey[600] : Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: status == 'completed'
                  ? null
                  : () => controller.markOrderAsDone(orderData['id']),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: status == 'completed'
                      ? Colors.green[400]
                      : const Color(0xFF4A90E2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  status == 'completed' ? 'Completed' : 'Mark as Done',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}