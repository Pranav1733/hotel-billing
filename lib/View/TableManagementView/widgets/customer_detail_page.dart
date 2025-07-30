// lib/features/table_management/views/widgets/customer_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Controller/table_management_controller.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({super.key});

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  late TableManagementController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<TableManagementController>();
    // Ensure controllers are properly initialized when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.onReturningToCustomerDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Alpani Hotel',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // Logout functionality
            },
            child: Text(
              'logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recipient name :',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(() => Text(
                        'table no : ${controller.selectedTable.value?['number'] ?? 1}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      )),
                ],
              ),
              SizedBox(height: 16.h),

              // Customer name field
              TextFormField(
                controller: controller.customerNameController,
                decoration: InputDecoration(
                  hintText: 'Enter full name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                validator: controller.validateCustomerName,
                onChanged: (value) => controller.saveCustomerDetails(),
              ),
              SizedBox(height: 16.h),

              // Phone number field
              TextFormField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                validator: controller.validatePhoneNumber,
                onChanged: (value) => controller.saveCustomerDetails(),
              ),
              SizedBox(height: 24.h),

              // Items section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items :',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Mark as urgent functionality
                        },
                        child: Text(
                          'mark as urgent',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      ElevatedButton(
                        onPressed: controller.navigateToAddItems,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                        ),
                        child: Text(
                          'add items +',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Selected items list
              Expanded(
                child: Obx(() => controller.selectedDishes.isEmpty
                    ? Center(
                        child: Text(
                          'No items selected',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.selectedDishes.length,
                        itemBuilder: (context, index) {
                          final dish = controller.selectedDishes[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 8.h),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.drag_indicator,
                                    color: Colors.blue[600],
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      dish['name'],
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            controller.updateDishQuantity(
                                                dish, dish['quantity'] - 1),
                                        icon: Icon(Icons.remove, size: 16.sp),
                                        constraints: BoxConstraints(
                                          minWidth: 32.w,
                                          minHeight: 32.h,
                                        ),
                                      ),
                                      Container(
                                        width: 40.w,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${dish['quantity']}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            controller.updateDishQuantity(
                                                dish, dish['quantity'] + 1),
                                        icon: Icon(Icons.add, size: 16.sp),
                                        constraints: BoxConstraints(
                                          minWidth: 32.w,
                                          minHeight: 32.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '₹${(dish['price'] as double).toInt()}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '₹${((dish['price'] as double) * (dish['quantity'] as int)).toInt()}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
              ),

              // Bottom section
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Final Checkout Total',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(() => Text(
                          '₹ ${controller.getTotalAmount().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[600],
                          ),
                        )),
                  ],
                ),
              ),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // KOT to chef functionality
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'kot to chef',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.selectedDishes.isEmpty
                              ? null
                              : controller.completeOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'kot to manager',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
