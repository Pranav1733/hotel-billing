// // lib/features/table_management/views/widgets/dish_card_widget.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class DishCardWidget extends StatelessWidget {
//   final Map<String, dynamic> dish;
//   final VoidCallback onTap;
//
//   const DishCardWidget({
//     super.key,
//     required this.dish,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = dish['isSelected'] ?? false;
//     final Color backgroundColor = isSelected ? Colors.green[400]! : Colors.grey[300]!;
//     final Color textColor = isSelected ? Colors.white : Colors.black87;
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(8.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 2.r,
//               offset: Offset(0, 1.h),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               dish['name'],
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600,
//                 color: textColor,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             SizedBox(height: 4.h),
//             Text(
//               '₹${dish['price'].toInt()}',
//               style: TextStyle(
//                 fontSize: 11.sp,
//                 color: textColor.withOpacity(0.8),
//               ),
//             ),
//             if (isSelected) ...[
//               SizedBox(height: 4.h),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 6.w,
//                   vertical: 2.h,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(4.r),
//                 ),
//                 child: Text(
//                   'Qty: ${dish['quantity']}',
//                   style: TextStyle(
//                     fontSize: 10.sp,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Controller/table_management_controller.dart';

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
final controller = Get.find<TableManagementController>();

return Obx(() {
// Get the current dish data from the controller to ensure reactivity
final currentDish = controller.filteredDishes.firstWhere(
(d) => d['id'] == dish['id'],
orElse: () => dish,
);

final bool isSelected = currentDish['isSelected'] ?? false;
final int quantity = currentDish['quantity'] ?? 0;
final int confirmedQty = controller.getConfirmedQuantity(currentDish['id']);
final bool hasConfirmedQty = confirmedQty > 0;

// Color logic based on selection and confirmation status
Color backgroundColor;
Color textColor;
Color borderColor;

if (isSelected) {
if (hasConfirmedQty) {
backgroundColor = Colors.orange[400]!; // Orange for confirmed items
borderColor = Colors.orange[600]!;
} else {
backgroundColor = Colors.green[400]!; // Green for newly selected
borderColor = Colors.green[600]!;
}
textColor = Colors.white;
} else {
backgroundColor = Colors.grey[300]!;
borderColor = Colors.grey[400]!;
textColor = Colors.black87;
}

return GestureDetector(
onTap: onTap,
child: Container(
decoration: BoxDecoration(
color: backgroundColor,
borderRadius: BorderRadius.circular(8.r),
border: Border.all(color: borderColor, width: 1.5),
boxShadow: [
BoxShadow(
color: Colors.black12,
blurRadius: 3.r,
offset: Offset(0, 2.h),
),
],
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
// Dish name
Padding(
padding: EdgeInsets.symmetric(horizontal: 4.w),
child: Text(
currentDish['name'],
style: TextStyle(
fontSize: 12.sp,
fontWeight: FontWeight.w600,
color: textColor,
),
textAlign: TextAlign.center,
maxLines: 2,
overflow: TextOverflow.ellipsis,
),
),

SizedBox(height: 4.h),

// Price
Text(
'₹${currentDish['price'].toInt()}',
style: TextStyle(
fontSize: 11.sp,
color: textColor.withOpacity(0.8),
fontWeight: FontWeight.w500,
),
),

// Quantity controls (shown when selected)
if (isSelected) ...[
SizedBox(height: 6.h),

// Quantity display with confirmed info
if (hasConfirmedQty) ...[
Container(
padding: EdgeInsets.symmetric(
horizontal: 4.w,
vertical: 1.h,
),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.2),
borderRadius: BorderRadius.circular(3.r),
),
child: Text(
'Min: $confirmedQty',
style: TextStyle(
fontSize: 9.sp,
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
SizedBox(height: 4.h),
],

// Quantity controls
Container(
padding: EdgeInsets.symmetric(horizontal: 2.w),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
// Decrease button
GestureDetector(
onTap: () {
controller.updateDishQuantity(currentDish, quantity - 1);
},
child: Container(
width: 20.w,
height: 20.h,
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.3),
borderRadius: BorderRadius.circular(3.r),
border: Border.all(
color: Colors.white.withOpacity(0.5),
width: 1,
),
),
child: Icon(
Icons.remove,
size: 12.sp,
color: Colors.white,
),
),
),

// Quantity display
Container(
width: 24.w,
alignment: Alignment.center,
child: Text(
'$quantity',
style: TextStyle(
fontSize: 14.sp,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
),

// Increase button
GestureDetector(
onTap: () {
controller.updateDishQuantity(currentDish, quantity + 1);
},
child: Container(
width: 20.w,
height: 20.h,
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.3),
borderRadius: BorderRadius.circular(3.r),
border: Border.all(
color: Colors.white.withOpacity(0.5),
width: 1,
),
),
child: Icon(
Icons.add,
size: 12.sp,
color: Colors.white,
),
),
),
],
),
),
],
],
),
),
);
});
}
}
