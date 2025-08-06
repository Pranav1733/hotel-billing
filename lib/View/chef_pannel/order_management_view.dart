// lib/features/order_management/views/order_management_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:setuapp/View/chef_pannel/widgets/cancel_order_model_widget.dart';
import '../../Controller/order_management _controller.dart';
import 'widgets/order_card_widget.dart';

class OrderManagementView extends StatelessWidget {
  const OrderManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderManagementController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(controller),

                // Filter tabs
                _buildFilterTabs(controller),

                // Orders list
                Expanded(
                  child: _buildOrdersList(controller),
                ),
              ],
            ),
          ),

          // Side drawer
          // Obx(() => AnimatedPositioned(
          //   duration: const Duration(milliseconds: 300),
          //   left: controller.showSideDrawer.value ? 0 : -250.w,
          //   top: 0,
          //   bottom: 0,
          //   child: const SideDrawerWidget(),
          // )),

          // Cancel order modal
          Obx(() => controller.showCancelModal.value
              ? const CancelOrderModal()
              : const SizedBox.shrink()),

          // Loading overlay
          Obx(() => controller.isLoading.value
              ? Container(
            color: Colors.black26,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildHeader(OrderManagementController controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.toggleSideDrawer,
            child: Icon(
              Icons.menu,
              size: 24.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alpani Hotel',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '2614 Sweetwater Rd, Santa Ana, Illinois 65466',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'tel: (406) 555-0120',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'logout',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(OrderManagementController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        children: [
          // Main tabs (accept orders / done orders)
          Row(
            children: [
              Expanded(
                child: Obx(() => GestureDetector(
                  onTap: () => controller.switchTab(0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: controller.currentTab.value == 0
                          ? const Color(0xFF4A90E2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: controller.currentTab.value == 0
                            ? const Color(0xFF4A90E2)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Text(
                      'accept orders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: controller.currentTab.value == 0
                            ? Colors.white
                            : Colors.grey[700],
                      ),
                    ),
                  ),
                )),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Obx(() => GestureDetector(
                  onTap: () => controller.switchTab(1),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: controller.currentTab.value == 1
                          ? const Color(0xFF4A90E2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: controller.currentTab.value == 1
                            ? const Color(0xFF4A90E2)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Text(
                      'done orders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: controller.currentTab.value == 1
                            ? Colors.white
                            : Colors.grey[700],
                      ),
                    ),
                  ),
                )),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(controller, 'all', 'all'),
                SizedBox(width: 8.w),
                _buildFilterChip(controller, 'dine in', 'dine_in'),
                SizedBox(width: 8.w),
                _buildFilterChip(controller, 'takeaway', 'takeaway'),
                SizedBox(width: 8.w),
                _buildFilterChip(controller, 'delivery', 'delivery'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(OrderManagementController controller, String label, String value) {
    return Obx(() => GestureDetector(
      onTap: () => controller.filterOrdersByType(value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: controller.selectedOrderType.value == value
              ? const Color(0xFF4A90E2)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: controller.selectedOrderType.value == value
                ? Colors.white
                : Colors.grey[700],
          ),
        ),
      ),
    ));
  }

  Widget _buildOrdersList(OrderManagementController controller) {
    return Obx(() {
      final orders = controller.filteredOrders;

      if (orders.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 64.sp,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16.h),
              Text(
                'No orders found',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Orders will appear here when available',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refreshOrders,
        child: ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return OrderCardWidget(
              orderData: orders[index],
              isAcceptTab: controller.currentTab.value == 0,
            );
          },
        ),
      );
    });
  }
}