// // lib/features/table_management/controllers/table_management_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:setuapp/Route%20Manager/app_routes.dart';
//
// class TableManagementController extends GetxController {
//   // Reactive variables
//   final tables = <Map<String, dynamic>>[].obs;
//   final selectedTable = Rxn<Map<String, dynamic>>();
//   final customerData = Rxn<Map<String, dynamic>>();
//   final selectedDishes = <Map<String, dynamic>>[].obs;
//   final availableDishes = <Map<String, dynamic>>[].obs;
//   final filteredDishes = <Map<String, dynamic>>[].obs;
//   final selectedFilter = 'All'.obs;
//   final isLoading = false.obs;
//   final errorMessage = ''.obs;
//
//   // Form controllers - Initialize them properly
//   late TextEditingController customerNameController;
//   late TextEditingController phoneController;
//   final formKey = GlobalKey<FormState>();
//
//   // Filter options
//   final filterOptions =
//       ['All', 'Veg', 'Non-Veg', 'Indian', 'Chinese', 'Beverages', 'Liquor'].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeControllers();
//     initializeTables();
//     initializeDishes();
//   }
//
//   @override
//   void onClose() {
//     _disposeControllers();
//     super.onClose();
//   }
//
//   // Initialize controllers
//   void _initializeControllers() {
//     customerNameController = TextEditingController();
//     phoneController = TextEditingController();
//   }
//
//   // Dispose controllers safely
//   void _disposeControllers() {
//     if (customerNameController.hasListeners ||
//         customerNameController.text.isNotEmpty) {
//       customerNameController.dispose();
//     }
//     if (phoneController.hasListeners || phoneController.text.isNotEmpty) {
//       phoneController.dispose();
//     }
//   }
//
//   // Reinitialize controllers if needed
//   void _ensureControllersExist() {
//     try {
//       // Test if controllers are still valid
//       customerNameController.text;
//       phoneController.text;
//     } catch (e) {
//       // Controllers are disposed, recreate them
//       customerNameController = TextEditingController();
//       phoneController = TextEditingController();
//     }
//   }
//
//   void initializeTables() {
//     tables.value = List.generate(
//         10,
//         (index) => {
//               'id': index + 1,
//               'number': index + 1,
//               'status': 'empty', // empty, occupied
//               'price': 0.0,
//               'timer': 0, // in minutes
//               'customerName': '',
//               'phoneNumber': '',
//               'orderedItems': <Map<String, dynamic>>[],
//               'orderTime': null,
//             });
//   }
//
//   void initializeDishes() {
//     availableDishes.value = [
//       {
//         'id': 1,
//         'name': 'Paneer Tikka',
//         'price': 250.0,
//         'category': 'Veg',
//         'subcategory': 'Indian',
//         'isSelected': false,
//         'quantity': 0,
//       },
//       {
//         'id': 2,
//         'name': 'Chicken Curry',
//         'price': 350.0,
//         'category': 'Non-Veg',
//         'subcategory': 'Indian',
//         'isSelected': false,
//         'quantity': 0,
//       },
//       {
//         'id': 3,
//         'name': 'Fried Rice',
//         'price': 180.0,
//         'category': 'Veg',
//         'subcategory': 'Chinese',
//         'isSelected': false,
//         'quantity': 0,
//       },
//       {
//         'id': 4,
//         'name': 'Beer',
//         'price': 150.0,
//         'category': 'Beverages',
//         'subcategory': 'Liquor',
//         'isSelected': false,
//         'quantity': 0,
//       },
//       {
//         'id': 5,
//         'name': 'Mutton Biryani',
//         'price': 450.0,
//         'category': 'Non-Veg',
//         'subcategory': 'Indian',
//         'isSelected': false,
//         'quantity': 0,
//       },
//     ];
//     filteredDishes.value = List.from(availableDishes);
//   }
//
//   void selectTable(Map<String, dynamic> table) {
//     if (table['status'] == 'empty') {
//       selectedTable.value = table;
//       clearCustomerForm();
//       _ensureControllersExist(); // Ensure controllers exist before navigation
//       Get.toNamed(AppRoutes.customerDetails, arguments: table['id']);
//     } else {
//       Get.snackbar(
//         'Table Occupied',
//         'Table ${table['number']} is currently occupied',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   void clearCustomerForm() {
//     _ensureControllersExist(); // Ensure controllers exist
//     customerNameController.clear();
//     phoneController.clear();
//     selectedDishes.clear();
//     customerData.value = null;
//   }
//
//   String? validateCustomerName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return null; // Optional field
//     }
//     if (value.trim().length < 2) {
//       return 'Name must be at least 2 characters';
//     }
//     return null;
//   }
//
//   String? validatePhoneNumber(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return null; // Optional field
//     }
//     final phoneRegex = RegExp(r'^[0-9]{10}$');
//     if (!phoneRegex.hasMatch(value.trim())) {
//       return 'Please enter a valid 10-digit phone number';
//     }
//     return null;
//   }
//
//   void saveCustomerDetails() {
//     _ensureControllersExist(); // Ensure controllers exist
//     if (formKey.currentState?.validate() ?? false) {
//       customerData.value = {
//         'name': customerNameController.text.trim(),
//         'phone': phoneController.text.trim(),
//       };
//       Get.snackbar(
//         'Success',
//         'Customer details saved',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   void navigateToAddItems() {
//     Get.toNamed('/add-items');
//   }
//
//   void filterDishes(String filter) {
//     selectedFilter.value = filter;
//     if (filter == 'All') {
//       filteredDishes.value = List.from(availableDishes);
//     } else {
//       filteredDishes.value = availableDishes
//           .where((dish) =>
//               dish['category'] == filter || dish['subcategory'] == filter)
//           .toList();
//     }
//   }
//
//   void toggleDishSelection(Map<String, dynamic> dish) {
//     final index = availableDishes.indexWhere((d) => d['id'] == dish['id']);
//     if (index != -1) {
//       availableDishes[index]['isSelected'] =
//           !availableDishes[index]['isSelected'];
//
//       if (availableDishes[index]['isSelected']) {
//         availableDishes[index]['quantity'] = 1;
//         selectedDishes.add(Map<String, dynamic>.from(availableDishes[index]));
//       } else {
//         availableDishes[index]['quantity'] = 0;
//         selectedDishes.removeWhere((d) => d['id'] == dish['id']);
//       }
//
//       // Update filtered dishes
//       filterDishes(selectedFilter.value);
//       availableDishes.refresh();
//       selectedDishes.refresh();
//     }
//   }
//
//   void updateDishQuantity(Map<String, dynamic> dish, int quantity) {
//     if (quantity <= 0) {
//       toggleDishSelection(dish);
//       return;
//     }
//
//     final selectedIndex =
//         selectedDishes.indexWhere((d) => d['id'] == dish['id']);
//     final availableIndex =
//         availableDishes.indexWhere((d) => d['id'] == dish['id']);
//
//     if (selectedIndex != -1 && availableIndex != -1) {
//       selectedDishes[selectedIndex]['quantity'] = quantity;
//       availableDishes[availableIndex]['quantity'] = quantity;
//       selectedDishes.refresh();
//       availableDishes.refresh();
//     }
//   }
//
//   double getTotalAmount() {
//     return selectedDishes.fold(
//         0.0, (total, dish) => total + (dish['price'] * dish['quantity']));
//   }
//
//   Future<void> completeOrder() async {
//     if (selectedTable.value == null) return;
//
//     try {
//       isLoading.value = true;
//
//       // Mock API call
//       await Future.delayed(const Duration(seconds: 1));
//
//       final tableIndex =
//           tables.indexWhere((t) => t['id'] == selectedTable.value!['id']);
//
//       if (tableIndex != -1) {
//         tables[tableIndex]['status'] = 'occupied';
//         tables[tableIndex]['price'] = getTotalAmount();
//         tables[tableIndex]['customerName'] =
//             customerData.value?['name'] ?? 'Guest';
//         tables[tableIndex]['phoneNumber'] = customerData.value?['phone'] ?? '';
//         tables[tableIndex]['orderedItems'] = List.from(selectedDishes);
//         tables[tableIndex]['orderTime'] = DateTime.now();
//         tables[tableIndex]['timer'] = 0;
//
//         tables.refresh();
//
//         // Start timer for the table
//         startTableTimer(tables[tableIndex]);
//       }
//
//       Get.snackbar(
//         'Order Placed',
//         'Order placed successfully for Table ${selectedTable.value!['number']}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//
//       // Clear form and reset for next order
//       clearCustomerForm();
//       resetDishSelections();
//
//       // Navigate back to dashboard
//       Get.offAllNamed('/dashboard');
//     } catch (e) {
//       errorMessage.value = e.toString();
//       Get.snackbar(
//         'Error',
//         'Failed to place order: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void startTableTimer(Map<String, dynamic> table) {
//     // This would typically use a proper timer implementation
//     // For demo purposes, showing concept
//     final tableId = table['id'];
//     // Implementation would increment timer every minute
//   }
//
//   void navigateBackToCustomerDetails() {
//     _ensureControllersExist(); // Ensure controllers exist before going back
//     Get.back();
//   }
//
//   void resetDishSelections() {
//     for (var dish in availableDishes) {
//       dish['isSelected'] = false;
//       dish['quantity'] = 0;
//     }
//     selectedDishes.clear();
//     filteredDishes.value = List.from(availableDishes);
//     availableDishes.refresh();
//   }
//
//   // Method to refresh controller when returning to customer details
//   void onReturningToCustomerDetails() {
//     _ensureControllersExist();
//     // Restore any previously entered data if needed
//     if (customerData.value != null) {
//       customerNameController.text = customerData.value!['name'] ?? '';
//       phoneController.text = customerData.value!['phone'] ?? '';
//     }
//   }
// }
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
    if (table['status'] == 'empty') {
      selectedTable.value = table;
      clearCustomerForm();
      _ensureControllersExist();
      Get.toNamed('/customer-details', arguments: table['id']);
    } else {
      Get.snackbar(
        'Table Occupied',
        'Table ${table['number']} is currently occupied',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void clearCustomerForm() {
    _ensureControllersExist();
    customerNameController.clear();
    phoneController.clear();
    selectedDishes.clear();
    customerData.value = null;
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
  Future<void> completeOrder() async {
    if (selectedTable.value == null || selectedDishes.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select items before completing order',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Mock API call
      await Future.delayed(const Duration(seconds: 1));

      final tableIndex =
      tables.indexWhere((t) => t['id'] == selectedTable.value!['id']);

      if (tableIndex != -1) {
        // Update table status to occupied (RED)
        tables[tableIndex]['status'] = 'occupied';
        tables[tableIndex]['price'] = getTotalAmount();
        tables[tableIndex]['customerName'] =
            customerData.value?['name'] ?? 'Guest';
        tables[tableIndex]['phoneNumber'] = customerData.value?['phone'] ?? '';
        tables[tableIndex]['orderedItems'] = List.from(selectedDishes);
        tables[tableIndex]['orderTime'] = DateTime.now();
        tables[tableIndex]['timer'] = 1; // Start from 1 minute

        tables.refresh();

        // Start timer for the table
        startTableTimer(tables[tableIndex]);
      }

      Get.snackbar(
        'Order Completed',
        'KOT sent to manager! Table ${selectedTable.value!['number']} is now occupied',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear form and reset for next order
      clearCustomerForm();
      resetDishSelections();

      // Navigate back to main dashboard
      Get.back(); // Go back to table management view

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to complete order: ${e.toString()}',
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