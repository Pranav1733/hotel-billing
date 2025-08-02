
// lib/features/table_management/controllers/table_management_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class TableManagementController extends GetxController {
  // Reactive variables
  final tables = <Map<String, dynamic>>[].obs;
  final selectedTable = Rxn<Map<String, dynamic>>();
  final customerData = Rxn<Map<String, dynamic>>();
  final selectedDishes = <Map<String, dynamic>>[].obs;
  final availableDishes = <Map<String, dynamic>>[].obs;
  final filteredDishes = <Map<String, dynamic>>[].obs;
  final selectedFilter = 'All'.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // Map to store timers for each table
  final Map<int, Timer> _tableTimers = {};

  // Form controllers
  late TextEditingController customerNameController;
  late TextEditingController phoneController;
  final formKey = GlobalKey<FormState>();

  // Filter options
  final filterOptions =
      ['All', 'Veg', 'Non-Veg', 'Indian', 'Chinese', 'Beverages', 'Liquor'].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    initializeTables();
    initializeDishes();
  }

  @override
  void onClose() {
    _disposeControllers();
    _disposeAllTimers();
    super.onClose();
  }

  void _initializeControllers() {
    customerNameController = TextEditingController();
    phoneController = TextEditingController();
  }

  void _disposeControllers() {
    if (customerNameController.hasListeners ||
        customerNameController.text.isNotEmpty) {
      customerNameController.dispose();
    }
    if (phoneController.hasListeners || phoneController.text.isNotEmpty) {
      phoneController.dispose();
    }
  }

  void _disposeAllTimers() {
    for (var timer in _tableTimers.values) {
      timer.cancel();
    }
    _tableTimers.clear();
  }

  void _ensureControllersExist() {
    try {
      customerNameController.text;
      phoneController.text;
    } catch (e) {
      customerNameController = TextEditingController();
      phoneController = TextEditingController();
    }
  }

  void initializeTables() {
    tables.value = List.generate(
        10,
            (index) => {
          'id': index + 1,
          'number': index + 1,
          'status': 'empty', // empty, occupied
          'price': 0.0,
          'timer': 0, // in minutes
          'customerName': '',
          'phoneNumber': '',
          'orderedItems': <Map<String, dynamic>>[],
          'orderTime': null,
        });
  }

  void initializeDishes() {
    availableDishes.value = [
      {
        'id': 1,
        'name': 'Paneer Tikka',
        'price': 250.0,
        'category': 'Veg',
        'subcategory': 'Indian',
        'isSelected': false,
        'quantity': 0,
      },
      {
        'id': 2,
        'name': 'Chicken Curry',
        'price': 350.0,
        'category': 'Non-Veg',
        'subcategory': 'Indian',
        'isSelected': false,
        'quantity': 0,
      },
      {
        'id': 3,
        'name': 'Fried Rice',
        'price': 180.0,
        'category': 'Veg',
        'subcategory': 'Chinese',
        'isSelected': false,
        'quantity': 0,
      },
      {
        'id': 4,
        'name': 'Beer',
        'price': 150.0,
        'category': 'Beverages',
        'subcategory': 'Liquor',
        'isSelected': false,
        'quantity': 0,
      },
      {
        'id': 5,
        'name': 'Mutton Biryani',
        'price': 450.0,
        'category': 'Non-Veg',
        'subcategory': 'Indian',
        'isSelected': false,
        'quantity': 0,
      },
    ];
    filteredDishes.value = List.from(availableDishes);
  }

  void selectTable(Map<String, dynamic> table) {
    selectedTable.value = table;
    _ensureControllersExist();

    if (table['status'] == 'empty') {
      clearCustomerForm();
      Get.toNamed('/customer-details', arguments: table['id']);
    } else {
      // Load existing customer data and items for occupied table
      loadExistingTableData(table);
      Get.toNamed('/customer-details', arguments: table['id']);
    }
  }

  void loadExistingTableData(Map<String, dynamic> table) {
    // Load existing customer details
    customerNameController.text = table['customerName'] ?? '';
    phoneController.text = table['phoneNumber'] ?? '';

    customerData.value = {
      'name': table['customerName'] ?? '',
      'phone': table['phoneNumber'] ?? '',
    };

    // Load existing ordered items
    selectedDishes.clear();
    if (table['orderedItems'] != null) {
      selectedDishes.addAll(List<Map<String, dynamic>>.from(table['orderedItems']));
    }

    // Update available dishes to reflect selected items
    for (var selectedDish in selectedDishes) {
      final availableIndex = availableDishes.indexWhere((d) => d['id'] == selectedDish['id']);
      if (availableIndex != -1) {
        availableDishes[availableIndex]['isSelected'] = true;
        availableDishes[availableIndex]['quantity'] = selectedDish['quantity'];
      }
    }

    selectedDishes.refresh();
    availableDishes.refresh();
  }

  void clearCustomerForm() {
    _ensureControllersExist();
    // Only clear if it's a new table selection (empty table)
    if (selectedTable.value?['status'] == 'empty') {
      customerNameController.clear();
      phoneController.clear();
      selectedDishes.clear();
      customerData.value = null;
      resetDishSelections();
    }
  }

  String? validateCustomerName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  void saveCustomerDetails() {
    _ensureControllersExist();
    if (formKey.currentState?.validate() ?? false) {
      customerData.value = {
        'name': customerNameController.text.trim(),
        'phone': phoneController.text.trim(),
      };
      Get.snackbar(
        'Success',
        'Customer details saved',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void navigateToAddItems() {
    Get.toNamed('/add-items');
  }

  void navigateToOrdersScreen() {
    Get.toNamed('/orders');
  }

  void navigateToReadyOrders() {
    Get.toNamed('/orders');
  }

  void filterDishes(String filter) {
    selectedFilter.value = filter;
    if (filter == 'All') {
      filteredDishes.value = List.from(availableDishes);
    } else {
      filteredDishes.value = availableDishes
          .where((dish) =>
      dish['category'] == filter || dish['subcategory'] == filter)
          .toList();
    }
  }

  void toggleDishSelection(Map<String, dynamic> dish) {
    final index = availableDishes.indexWhere((d) => d['id'] == dish['id']);
    if (index != -1) {
      availableDishes[index]['isSelected'] =
      !availableDishes[index]['isSelected'];

      if (availableDishes[index]['isSelected']) {
        availableDishes[index]['quantity'] = 1;
        selectedDishes.add(Map<String, dynamic>.from(availableDishes[index]));
      } else {
        availableDishes[index]['quantity'] = 0;
        selectedDishes.removeWhere((d) => d['id'] == dish['id']);
      }

      filterDishes(selectedFilter.value);
      availableDishes.refresh();
      selectedDishes.refresh();
    }
  }

  void updateDishQuantity(Map<String, dynamic> dish, int quantity) {
    if (quantity <= 0) {
      toggleDishSelection(dish);
      return;
    }

    final selectedIndex =
    selectedDishes.indexWhere((d) => d['id'] == dish['id']);
    final availableIndex =
    availableDishes.indexWhere((d) => d['id'] == dish['id']);

    if (selectedIndex != -1 && availableIndex != -1) {
      selectedDishes[selectedIndex]['quantity'] = quantity;
      availableDishes[availableIndex]['quantity'] = quantity;
      selectedDishes.refresh();
      availableDishes.refresh();
    }
  }

  double getTotalAmount() {
    return selectedDishes.fold(
        0.0, (total, dish) => total + (dish['price'] * dish['quantity']));
  }

  // Method for "KOT to Chef" button
  void sendKotToChef() {
    if (selectedTable.value == null || selectedDishes.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select items before sending KOT to chef',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'KOT Sent',
      'Kitchen Order Ticket sent to chef for Table ${selectedTable.value!['number']}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  // Method for "KOT to Manager" button - This should mark table as occupied
// Updated completeOrder method with debugging and fixes
  Future<void> completeOrder() async {
    print("CompleteOrder called"); // Debug print

    // Check if selectedTable exists
    if (selectedTable.value == null) {
      print("No selected table"); // Debug print
      Get.snackbar(
        'Error',
        'No table selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Check if selectedDishes is empty
    if (selectedDishes.isEmpty) {
      print("No dishes selected"); // Debug print
      Get.snackbar(
        'Error',
        'Please select items before completing order',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      print("Starting order completion process"); // Debug print
      isLoading.value = true;

      // Mock API call
      await Future.delayed(const Duration(seconds: 1));

      final tableIndex = tables.indexWhere((t) => t['id'] == selectedTable.value!['id']);
      print("Table index found: $tableIndex"); // Debug print

      if (tableIndex != -1) {
        print("Updating table at index $tableIndex"); // Debug print

        // Update table status to occupied (RED)
        tables[tableIndex]['status'] = 'occupied';
        tables[tableIndex]['price'] = getTotalAmount();
        tables[tableIndex]['customerName'] = customerData.value?['name'] ?? 'Guest';
        tables[tableIndex]['phoneNumber'] = customerData.value?['phone'] ?? '';
        tables[tableIndex]['orderedItems'] = List.from(selectedDishes);

        // Only set order time and start timer if this is a new order
        if (tables[tableIndex]['orderTime'] == null) {
          tables[tableIndex]['orderTime'] = DateTime.now();
          tables[tableIndex]['timer'] = 1; // Start from 1 minute
          startTableTimer(tables[tableIndex]);
        }

        // Force refresh the tables observable
        tables.refresh();

        print("Table updated successfully"); // Debug print

        // Show success snackbar
        Get.snackbar(
          'Order Completed',
          'KOT sent to manager! Table ${selectedTable.value!['number']} updated',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        print("Snackbar should be visible now"); // Debug print

        // Wait a bit before navigating back to ensure snackbar is visible
        await Future.delayed(const Duration(milliseconds: 500));

        // Navigate back to table management view
          Get.offNamed('/dashboard');


      } else {
        print("Table not found in tables list"); // Debug print
        Get.snackbar(
          'Error',
          'Table not found',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }

    } catch (e) {
      print("Error in completeOrder: $e"); // Debug print
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to complete order: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
      print("Loading set to false"); // Debug print
    }
  }
  // Method to checkout and free the table
  Future<void> checkoutTable() async {
    if (selectedTable.value == null) {
      Get.snackbar(
        'Error',
        'No table selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Mock checkout process
      await Future.delayed(const Duration(seconds: 1));

      final tableIndex =
      tables.indexWhere((t) => t['id'] == selectedTable.value!['id']);

      if (tableIndex != -1) {
        final tableNumber = tables[tableIndex]['number'];
        final totalAmount = tables[tableIndex]['price'];

        // Free the table
        freeTable(tables[tableIndex]);

        Get.snackbar(
          'Checkout Complete',
          'Table $tableNumber checkout completed. Total: ₹${totalAmount.toStringAsFixed(2)}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Navigate back to table management view
        Get.offNamed('/dashboard');

      }

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to checkout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void startTableTimer(Map<String, dynamic> table) {
    final tableId = table['id'] as int;

    // Cancel existing timer if any
    _tableTimers[tableId]?.cancel();

    // Start new timer that increments every minute
    _tableTimers[tableId] = Timer.periodic(const Duration(minutes: 1), (timer) {
      final tableIndex = tables.indexWhere((t) => t['id'] == tableId);
      if (tableIndex != -1) {
        tables[tableIndex]['timer'] = tables[tableIndex]['timer'] + 1;
        tables.refresh();
      } else {
        // Table not found, cancel timer
        timer.cancel();
        _tableTimers.remove(tableId);
      }
    });
  }

  void stopTableTimer(int tableId) {
    _tableTimers[tableId]?.cancel();
    _tableTimers.remove(tableId);
  }

  void freeTable(Map<String, dynamic> table) {
    final tableIndex = tables.indexWhere((t) => t['id'] == table['id']);
    if (tableIndex != -1) {
      // Stop timer
      stopTableTimer(table['id']);

      // Reset table to empty status (GREEN)
      tables[tableIndex]['status'] = 'empty';
      tables[tableIndex]['price'] = 0.0;
      tables[tableIndex]['timer'] = 0;
      tables[tableIndex]['customerName'] = '';
      tables[tableIndex]['phoneNumber'] = '';
      tables[tableIndex]['orderedItems'] = <Map<String, dynamic>>[];
      tables[tableIndex]['orderTime'] = null;

      tables.refresh();

      Get.snackbar(
        'Table Freed',
        'Table ${table['number']} is now available',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void navigateBackToCustomerDetails() {
    _ensureControllersExist();
    Get.back();
  }

  void resetDishSelections() {
    for (var dish in availableDishes) {
      dish['isSelected'] = false;
      dish['quantity'] = 0;
    }
    selectedDishes.clear();
    filteredDishes.value = List.from(availableDishes);
    availableDishes.refresh();
  }

  void onReturningToCustomerDetails() {
    _ensureControllersExist();
    if (customerData.value != null) {
      customerNameController.text = customerData.value!['name'] ?? '';
      phoneController.text = customerData.value!['phone'] ?? '';
    }
  }
}