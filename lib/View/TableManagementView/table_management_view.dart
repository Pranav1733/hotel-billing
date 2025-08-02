// // lib/features/table_management/views/table_management_view.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../Controller/table_management_controller.dart';
// import 'widgets/table_widget.dart';
//
// class TableManagementView extends StatelessWidget {
//   const TableManagementView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(TableManagementController());
//
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: Text(
//           'Alpani Hotel',
//           style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blue[600],
//         elevation: 0,
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Logout functionality
//             },
//             child: Text(
//               'logout',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14.sp,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Header buttons
//           Container(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Take orders functionality
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[600],
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                     ),
//                     child: Text(
//                       'take orders',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {
//                       // Ready orders functionality
//                     },
//                     style: OutlinedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                     ),
//                     child: Text(
//                       'ready orders',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Tables grid
//           Expanded(
//             child: Container(
//               color: Colors.yellow[100],
//               padding: EdgeInsets.all(16.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Common area',
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   Expanded(
//                     child: Obx(() => GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4,
//                         childAspectRatio: 0.8,
//                         crossAxisSpacing: 10.w,
//                         mainAxisSpacing: 10.h,
//                       ),
//                       itemCount: controller.tables.length,
//                       itemBuilder: (context, index) {
//                         final table = controller.tables[index];
//                         return TableWidget(
//                           table: table,
//                           onTap: () => controller.selectTable(table),
//                         );
//                       },
//                     )),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//


// lib/features/table_management/views/table_management_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Controller/table_management_controller.dart';
import 'widgets/table_widget.dart';

class TableManagementView extends StatelessWidget {
  const TableManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TableManagementController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
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
          // Active orders indicator
          Obx(() {
            final activeOrders = controller.tables
                .where((table) => table['status'] == 'occupied')
                .length;
            return activeOrders > 0
                ? Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '$activeOrders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : SizedBox.shrink();
          }),
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
      body: Column(
        children: [
          // Header buttons
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Show table selection for taking new orders
                      Get.snackbar(
                        'Take Orders',
                        'Select an empty table (green) to take new orders',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'take orders',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.navigateToOrdersScreen,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: BorderSide(color: Colors.blue[600]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ready orders',
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Obx(() {
                          final activeOrders = controller.tables
                              .where((table) => table['status'] == 'occupied')
                              .length;
                          return activeOrders > 0
                              ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '$activeOrders',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                              : SizedBox.shrink();
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tables grid
          Expanded(
            child: Container(
              color: Colors.yellow[100],
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Common area',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      // Legend
                      Row(
                        children: [
                          _buildLegendItem(Colors.green[400]!, 'Available'),
                          SizedBox(width: 8.w),
                          _buildLegendItem(Colors.red[400]!, 'Occupied'),
                          SizedBox(width: 8.w),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: Obx(() => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                      ),
                      itemCount: controller.tables.length,
                      itemBuilder: (context, index) {
                        final table = controller.tables[index];
                        return TableWidget(
                          table: table,
                          onTap: () => controller.selectTable(table),
                        );
                      },
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}