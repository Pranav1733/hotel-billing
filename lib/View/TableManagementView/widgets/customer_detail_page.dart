import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
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
                      Obx(() => TextButton(
                            onPressed: () {
                              // Toggle urgent status
                              if (controller.selectedTable.value != null) {
                                final tableIndex = controller.tables.indexWhere(
                                    (t) =>
                                        t['id'] ==
                                        controller.selectedTable.value!['id']);
                                if (tableIndex != -1) {
                                  controller.tables[tableIndex]['isUrgent'] =
                                      !(controller.tables[tableIndex]
                                              ['isUrgent'] ??
                                          false);
                                  controller.tables.refresh();

                                  Get.snackbar(
                                    controller.tables[tableIndex]['isUrgent']
                                        ? 'Marked as Urgent'
                                        : 'Removed Urgent',
                                    'Table ${controller.tables[tableIndex]['number']} ${controller.tables[tableIndex]['isUrgent'] ? 'marked as urgent' : 'urgent status removed'}',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: controller
                                            .tables[tableIndex]['isUrgent']
                                        ? Colors.orange
                                        : Colors.blue,
                                    colorText: Colors.white,
                                  );
                                }
                              }
                            },
                            child: Text(
                              controller.selectedTable.value?['isUrgent'] ==
                                      true
                                  ? 'remove urgent'
                                  : 'mark as urgent',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: controller
                                            .selectedTable.value?['isUrgent'] ==
                                        true
                                    ? Colors.red[600]
                                    : Colors.grey[600],
                                fontWeight: controller
                                            .selectedTable.value?['isUrgent'] ==
                                        true
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )),
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
              // Expanded(
              //   child: Obx(() => controller.selectedDishes.isEmpty
              //       ? Center(
              //           child: Text(
              //             'No items selected',
              //             style: TextStyle(
              //               fontSize: 16.sp,
              //               color: Colors.grey[500],
              //             ),
              //           ),
              //         )
              //       : ListView.builder(
              //           itemCount: controller.selectedDishes.length,
              //           itemBuilder: (context, index) {
              //             final dish = controller.selectedDishes[index];
              //             return Card(
              //               margin: EdgeInsets.only(bottom: 8.h),
              //               child: Padding(
              //                 padding: EdgeInsets.all(12.w),
              //                 child: Row(
              //                   children: [
              //                     Icon(
              //                       Icons.drag_indicator,
              //                       color: Colors.blue[600],
              //                       size: 20.sp,
              //                     ),
              //                     SizedBox(width: 12.w),
              //                     Expanded(
              //                       child: Text(
              //                         dish['name'],
              //                         style: TextStyle(
              //                           fontSize: 14.sp,
              //                           fontWeight: FontWeight.w500,
              //                         ),
              //                       ),
              //                     ),
              //                     Row(
              //                       children: [
              //                         IconButton(
              //                           onPressed: () =>
              //                               controller.updateDishQuantity(
              //                                   dish, dish['quantity'] - 1),
              //                           icon: Icon(Icons.remove, size: 16.sp),
              //                           constraints: BoxConstraints(
              //                             minWidth: 32.w,
              //                             minHeight: 32.h,
              //                           ),
              //                         ),
              //                         Container(
              //                           width: 40.w,
              //                           alignment: Alignment.center,
              //                           child: Text(
              //                             '${dish['quantity']}',
              //                             style: TextStyle(
              //                               fontSize: 14.sp,
              //                               fontWeight: FontWeight.bold,
              //                             ),
              //                           ),
              //                         ),
              //                         IconButton(
              //                           onPressed: () =>
              //                               controller.updateDishQuantity(
              //                                   dish, dish['quantity'] + 1),
              //                           icon: Icon(Icons.add, size: 16.sp),
              //                           constraints: BoxConstraints(
              //                             minWidth: 32.w,
              //                             minHeight: 32.h,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     SizedBox(width: 8.w),
              //                     Text(
              //                       '₹${(dish['price'] as double).toInt()}',
              //                       style: TextStyle(
              //                         fontSize: 12.sp,
              //                         color: Colors.grey[600],
              //                       ),
              //                     ),
              //                     SizedBox(width: 8.w),
              //                     Text(
              //                       '₹${((dish['price'] as double) * (dish['quantity'] as int)).toInt()}',
              //                       style: TextStyle(
              //                         fontSize: 12.sp,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.green[600],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //         )),
              // ),

              // Bottom section
              // Complete updated ListView.builder for your CustomerDetailPage
// Replace the existing ListView.builder section with this:

              // Fixed ListView section for CustomerDetailPage
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
                    : Column(
                  children: [
                    // Header row with proper alignment
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    //   margin: EdgeInsets.only(bottom: 8.h),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[100],
                    //     borderRadius: BorderRadius.circular(6.r),
                    //     border: Border.all(color: Colors.grey[300]!),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       // Serial number column
                    //       SizedBox(
                    //         width: 30.w,
                    //         child: Text(
                    //           '#',
                    //           style: TextStyle(
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.grey[700],
                    //           ),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //
                    //       SizedBox(width: 12.w),
                    //
                    //       // Item name column
                    //       Expanded(
                    //         flex: 3,
                    //         child: Text(
                    //           'Item',
                    //           style: TextStyle(
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.grey[700],
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       // Quantity column
                    //       SizedBox(
                    //         width: 80.w,
                    //         child: Text(
                    //           'Quantity',
                    //           style: TextStyle(
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.grey[700],
                    //           ),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //
                    //       // Price column
                    //       SizedBox(
                    //         width: 50.w,
                    //         child: Text(
                    //           'Price',
                    //           style: TextStyle(
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.grey[700],
                    //           ),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //
                    //       // Total column
                    //       SizedBox(
                    //         width: 40.w,
                    //         child: Text(
                    //           'Total',
                    //           style: TextStyle(
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.grey[700],
                    //           ),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Items list
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.selectedDishes.length,
                        itemBuilder: (context, index) {
                          final dish = controller.selectedDishes[index];
                          final serialNumber = index + 1;

 return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(color: Colors.grey[200]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 4.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Serial Number
                                Container(
                                  width: 20.w,
                                  child: Container(
                                    width: 24.w,
                                    height: 24.h,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[600],
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$serialNumber',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 12.w),

                                // Item details
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dish['name'],
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                    ],
                                  ),
                                ),

                                // Quantity controls
                                SizedBox(
                                  width: 70.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => controller.updateDishQuantity(
                                            dish, dish['quantity'] - 1),
                                        child: Container(
                                          width: 20.w,
                                          height: 24.h,
                                          decoration: BoxDecoration(
                                            color: Colors.red[50],
                                            borderRadius: BorderRadius.circular(4.r),
                                            border: Border.all(color: Colors.red[200]!),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            size: 14.sp,
                                            color: Colors.red[600],
                                          ),
                                        ),
                                      ),

                                      Container(
                                        width: 23.w,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${dish['quantity']}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () => controller.updateDishQuantity(
                                            dish, dish['quantity'] + 1),
                                        child: Container(
                                          width: 20.w,
                                          height: 24.h,
                                          decoration: BoxDecoration(
                                            color: Colors.green[50],
                                            borderRadius: BorderRadius.circular(4.r),
                                            border: Border.all(color: Colors.green[200]!),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: 14.sp,
                                            color: Colors.green[600],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Unit Price
                                SizedBox(
                                  width: 30.w,
                                  child: Text(
                                    '₹${(dish['price'] as double).toInt()}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                // Total Price
                                SizedBox(
                                  width: 60.w,
                                  child: Text(
                                    '₹${((dish['price'] as double) * (dish['quantity'] as int)).toInt()}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Final Checkout Total',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Obx(() => Text(
                              '₹ ${controller.getTotalAmount().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[600],
                              ),
                            )),
                      ],
                    ),
                    // Checkout button
                    Obx(() => ElevatedButton(
                          onPressed:
                              controller.selectedTable.value?['status'] ==
                                          'occupied' &&
                                      controller.selectedDishes.isNotEmpty
                                  ? controller.checkoutTable
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 12.h,
                            ),
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
                                  'Checkout',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                      onPressed: controller.sendKotToChef,
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
