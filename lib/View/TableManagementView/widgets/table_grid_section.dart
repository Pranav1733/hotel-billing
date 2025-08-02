import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Controller/table_management_controller.dart';
import 'table_widget.dart';

class TableGridSection extends StatelessWidget {
  const TableGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TableManagementController>();

    return Expanded(
      child: Container(
        color: Colors.yellow[100],
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Common area', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
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
    );
  }
}
