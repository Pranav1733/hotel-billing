// lib/features/order_management/controllers/order_management_controller.dart

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OrderManagementController extends GetxController {
  // Reactive state variables
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final currentTab = 0.obs; // 0 for accept orders, 1 for done orders
  final selectedOrderType = 'all'.obs; // all, dine in, takeaway, delivery

  // Orders data stored as Map<String, dynamic>
  final pendingOrders = RxList<Map<String, dynamic>>([]);
  final completedOrders = RxList<Map<String, dynamic>>([]);

  // Modal states
  final showCancelModal = false.obs;
  final selectedOrderId = ''.obs;
  final cancelReasonController = TextEditingController();
  final cancelFormKey = GlobalKey<FormState>();

  // Side drawer state
  final showSideDrawer = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  @override
  void onReady() {
    super.onReady();
    // Any additional setup after UI is ready
  }

  @override
  void onClose() {
    cancelReasonController.dispose();
    super.onClose();
  }

  // Load initial orders data
  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Mock API call - replace with actual API
      await Future.delayed(const Duration(seconds: 1));

      // Mock pending orders data
      final mockPendingOrders = [
        {
          'id': '1',
          'orderNumber': 'Order no. 1',
          'tableNumber': 'table no: 7',
          'time': '9:41',
          'customerDetails': [
            {'label': 'food items', 'value': '', 'count': 1},
            {'label': 'Enter full name', 'value': '', 'count': 1},
            {'label': 'Enter full name', 'value': '', 'count': 1},
          ],
          'status': 'pending',
          'type': 'dine_in'
        },
        {
          'id': '4',
          'orderNumber': 'Order no. 4',
          'tableNumber': 'table no: 6',
          'time': '9:41',
          'customerDetails': [
            {'label': 'Enter full name', 'value': '', 'count': 1},
          ],
          'status': 'pending',
          'type': 'takeaway'
        }
      ];

      // Mock completed orders data
      final mockCompletedOrders = [
        {
          'id': '2',
          'orderNumber': 'Order no. 1',
          'tableNumber': 'table no: 7',
          'time': '9:30',
          'customerDetails': [
            {'label': 'Enter full name', 'value': 'John Doe', 'count': 1},
            {'label': 'customisation', 'value': 'Extra spicy', 'count': 0},
          ],
          'status': 'preparing',
          'type': 'delivery'
        }
      ];

      pendingOrders.assignAll(mockPendingOrders);
      completedOrders.assignAll(mockCompletedOrders);

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load orders: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Switch between tabs
  void switchTab(int index) {
    currentTab.value = index;
  }

  // Filter orders by type
  void filterOrdersByType(String type) {
    selectedOrderType.value = type;
  }

  // Get filtered orders based on current tab and filter
  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> orders = currentTab.value == 0
        ? pendingOrders
        : completedOrders;

    if (selectedOrderType.value == 'all') {
      return orders;
    }

    return orders.where((order) =>
    order['type'] == selectedOrderType.value.replaceAll(' ', '_')
    ).toList();
  }

  // Accept order
  Future<void> acceptOrder(String orderId) async {
    try {
      isLoading.value = true;

      // Mock API call
      await Future.delayed(const Duration(seconds: 1));

      // Find and move order from pending to completed
      final orderIndex = pendingOrders.indexWhere((order) => order['id'] == orderId);
      if (orderIndex != -1) {
        final order = Map<String, dynamic>.from(pendingOrders[orderIndex]);
        order['status'] = 'preparing';

        pendingOrders.removeAt(orderIndex);
        completedOrders.add(order);
      }

      Get.snackbar(
        'Success',
        'Order accepted successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to accept order: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Show cancel order modal
  void showCancelOrderModal(String orderId) {
    selectedOrderId.value = orderId;
    showCancelModal.value = true;
    cancelReasonController.clear();
  }

  // Hide cancel order modal
  void hideCancelOrderModal() {
    showCancelModal.value = false;
    selectedOrderId.value = '';
    cancelReasonController.clear();
  }

  // Validate cancel reason
  String? validateCancelReason(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please provide a reason for cancellation';
    }
    if (value.trim().length < 10) {
      return 'Reason must be at least 10 characters long';
    }
    return null;
  }

  // Cancel order with reason
  Future<void> cancelOrderWithReason() async {
    if (!cancelFormKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // Mock API call
      await Future.delayed(const Duration(seconds: 1));

      // Remove order from pending orders
      pendingOrders.removeWhere((order) => order['id'] == selectedOrderId.value);

      hideCancelOrderModal();

      Get.snackbar(
        'Success',
        'Order cancelled successfully',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to cancel order: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Mark order as done
  Future<void> markOrderAsDone(String orderId) async {
    try {
      isLoading.value = true;

      // Mock API call
      await Future.delayed(const Duration(seconds: 1));

      // Update order status
      final orderIndex = completedOrders.indexWhere((order) => order['id'] == orderId);
      if (orderIndex != -1) {
        completedOrders[orderIndex]['status'] = 'completed';
        completedOrders.refresh(); // Trigger UI update
      }

      Get.snackbar(
        'Success',
        'Order marked as done',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to update order: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle side drawer
  void toggleSideDrawer() {
    showSideDrawer.value = !showSideDrawer.value;
  }

  // Navigate to settings
  void navigateToSettings() {
    showSideDrawer.value = false;
    Get.toNamed('/settings');
  }

  // Navigate to orders (close drawer)
  void navigateToOrders() {
    showSideDrawer.value = false;
  }

  // Refresh orders
  Future<void> refreshOrders() async {
    await loadInitialData();
  }
}