// // lib/features/table_management/views/widgets/add_items_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../Controller/table_management_controller.dart';
// import 'dish_card_widget.dart';
//
// class AddItemsPage extends StatelessWidget {
//   const AddItemsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<TableManagementController>();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
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
//           // Header
//           Container(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'add items',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//
//                 // Search bar
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search by name / code',
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.r),
//                     ),
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 16.w,
//                       vertical: 12.h,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//
//                 // Filter chips
//                 SizedBox(
//                   height: 40.h,
//                   child: Obx(() => ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: controller.filterOptions.length,
//                     itemBuilder: (context, index) {
//                       final filter = controller.filterOptions[index];
//                       final isSelected = controller.selectedFilter.value == filter;
//
//                       return Padding(
//                         padding: EdgeInsets.only(right: 8.w),
//                         child: ChoiceChip(
//                           label: Text(
//                             filter,
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: isSelected ? Colors.white : Colors.black87,
//                             ),
//                           ),
//                           selected: isSelected,
//                           onSelected: (selected) {
//                             if (selected) {
//                               controller.filterDishes(filter);
//                             }
//                           },
//                           selectedColor: Colors.green[600],
//                           backgroundColor: Colors.grey[200],
//                         ),
//                       );
//                     },
//                   )),
//                 ),
//               ],
//             ),
//           ),
//
//           // Dishes grid
//           Expanded(
//             child: Obx(() => GridView.builder(
//               padding: EdgeInsets.all(16.w),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 childAspectRatio: 1.0,
//                 crossAxisSpacing: 12.w,
//                 mainAxisSpacing: 12.h,
//               ),
//               itemCount: controller.filteredDishes.length,
//               itemBuilder: (context, index) {
//                 final dish = controller.filteredDishes[index];
//                 return DishCardWidget(
//                   dish: dish,
//                   onTap: () => controller.toggleDishSelection(dish),
//                 );
//               },
//             )),
//           ),
//
//           // Bottom navigation
//           Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 4.r,
//                   offset: Offset(0, -1.h),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {
//                       // Add to list functionality
//                     },
//                     style: OutlinedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'add to list',
//                       style: TextStyle(fontSize: 14.sp),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: controller.navigateBackToCustomerDetails,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[600],
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'next',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14.sp,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Controller/table_management_controller.dart';
import 'dish_card_widget.dart';

class AddItemsPage extends StatelessWidget {
  const AddItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TableManagementController>();

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
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       // Logout functionality
        //     },
        //     child: Text(
        //       'logout',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 14.sp,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'add items',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
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
        
                  // Search bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by name / code',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
        
                  // Filter chips
                  SizedBox(
                    height: 40.h,
                    child: Obx(() => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.filterOptions.length,
                      itemBuilder: (context, index) {
                        final filter = controller.filterOptions[index];
                        final isSelected = controller.selectedFilter.value == filter;
        
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: ChoiceChip(
                            label: Text(
                              filter,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                controller.filterDishes(filter);
                              }
                            },
                            selectedColor: Colors.green[600],
                            backgroundColor: Colors.grey[200],
                          ),
                        );
                      },
                    )),
                  ),
        
                  SizedBox(height: 12.h),
        
                  // Live total and selected items count
                  Obx(() {
                    final selectedCount = controller.selectedDishes.length;
                    final totalAmount = controller.getTotalAmount();
                    final hasConfirmedOrders = controller.hasConfirmedOrders();
        
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 16.sp,
                                color: Colors.blue[600],
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '$selectedCount items selected',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue[700],
                                ),
                              ),
                              if (hasConfirmedOrders) ...[
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[200],
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    'Has confirmed',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[800],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            '₹${totalAmount.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
        
            // Dishes grid
            Expanded(
              child: Obx(() => GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                ),
                itemCount: controller.filteredDishes.length,
                itemBuilder: (context, index) {
                  final dish = controller.filteredDishes[index];
                  return DishCardWidget(
                    dish: dish,
                    onTap: () => controller.toggleDishSelection(dish),
                  );
                },
              )),
            ),
        
            // Bottom navigation
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.r,
                    offset: Offset(0, -1.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Quick actions row
                  // Obx(() {
                  //   final hasItems = controller.selectedDishes.isNotEmpty;
                  //
                  //   return Row(
                  //     // children: [
                  //     //   // Clear all button (only for non-confirmed items)
                  //     //   Expanded(
                  //     //     child: OutlinedButton.icon(
                  //     //       onPressed: hasItems ? () {
                  //     //         // Show confirmation dialog
                  //     //         Get.dialog(
                  //     //           AlertDialog(
                  //     //             title: Text('Clear Selection'),
                  //     //             content: Text('Are you sure you want to clear all selected items? (Confirmed items cannot be removed)'),
                  //     //             actions: [
                  //     //               TextButton(
                  //     //                 onPressed: () => Get.back(),
                  //     //                 child: Text('Cancel'),
                  //     //               ),
                  //     //               TextButton(
                  //     //                 onPressed: () {
                  //     //                   controller.resetDishSelections();
                  //     //                   Get.back();
                  //     //                   Get.snackbar(
                  //     //                     'Cleared',
                  //     //                     'Selection cleared (keeping confirmed items)',
                  //     //                     snackPosition: SnackPosition.BOTTOM,
                  //     //                     backgroundColor: Colors.blue,
                  //     //                     colorText: Colors.white,
                  //     //                   );
                  //     //                 },
                  //     //                 child: Text('Clear'),
                  //     //               ),
                  //     //             ],
                  //     //           ),
                  //     //         );
                  //     //       } : null,
                  //     //       icon: Icon(Icons.clear_all, size: 16.sp),
                  //     //       label: Text(
                  //     //         'clear all',
                  //     //         style: TextStyle(fontSize: 12.sp),
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     //
                  //     //   SizedBox(width: 8.w),
                  //     //
                  //     // ],
                  //   );
                  // }),
        
                  SizedBox(height: 12.h),
        
                  // Main action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Add to list functionality - could save draft
                            Get.snackbar(
                              'Saved',
                              'Items added to order list',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            'add to list',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.navigateBackToCustomerDetails,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            'next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
