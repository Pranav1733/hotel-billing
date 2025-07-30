import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HotelRoomBookingController extends GetxController {
  // Observable state variables
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final selectedRoomId = ''.obs;
  final bookingData = Rxn<Map<String, dynamic>>();
  final hotelData = Rxn<Map<String, dynamic>>();
  final roomsData = <Map<String, dynamic>>[].obs;

  // Form controllers and validation
  final formKey = GlobalKey<FormState>();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final guestsController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Validation states
  final isFormValid = false.obs;
  final checkInError = ''.obs;
  final checkOutError = ''.obs;
  final guestsError = ''.obs;
  final nameError = ''.obs;
  final emailError = ''.obs;
  final phoneError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadHotelData();
    setupFormValidation();
  }

  @override
  void onReady() {
    super.onReady();
    fetchRoomsData();
  }

  @override
  void onClose() {
    checkInController.dispose();
    checkOutController.dispose();
    guestsController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void setupFormValidation() {
    // Real-time validation listeners
    checkInController.addListener(() => validateCheckIn());
    checkOutController.addListener(() => validateCheckOut());
    guestsController.addListener(() => validateGuests());
    nameController.addListener(() => validateName());
    emailController.addListener(() => validateEmail());
    phoneController.addListener(() => validatePhone());
  }

  void loadHotelData() {
    // Mock hotel data
    hotelData.value = {
      'name': 'Alpani Hotel',
      'address': '202 Wowheadfri Rd, Santa Ana, Apros 92649',
      'phone': '+91 8801 555 9996',
      'rating': 4.5,
      'amenities': ['WiFi', 'AC', 'TV', 'Room Service'],
    };
  }

  Future<void> fetchRoomsData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Mock API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock rooms data matching the screenshot
      final mockRoomsData = List.generate(20, (index) {
        final roomNumber = index + 1;
        final isAvailable = [0, 4, 8, 12, 16].contains(index); // Green rooms from screenshot

        return {
          'id': 'room_$roomNumber',
          'roomNumber': roomNumber,
          'price': 3500,
          'isAvailable': isAvailable,
          'type': 'Standard Room',
          'area': index < 10 ? 'Common area' : 'Common area',
          'amenities': ['AC', 'TV', 'WiFi'],
          'maxGuests': 2,
          'bedType': 'Queen Bed',
        };
      });

      roomsData.value = mockRoomsData;

    } catch (e) {
      errorMessage.value = 'Failed to load rooms data: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Failed to load rooms data',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectRoom(String roomId) {
    final room = roomsData.firstWhere(
          (room) => room['id'] == roomId,
      orElse: () => {},
    );

    if (room.isEmpty) return;

    if (!room['isAvailable']) {
      Get.snackbar(
        'Room Unavailable',
        'This room is currently occupied',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    selectedRoomId.value = roomId;
    Get.toNamed('/hotel-room-booking/booking-form');
  }

  // Form Validation Methods
  String? validateCheckIn() {
    final value = checkInController.text.trim();
    if (value.isEmpty) {
      checkInError.value = 'Check-in date is required';
      return checkInError.value;
    }

    try {
      final checkIn = DateTime.parse(value);
      final now = DateTime.now();
      if (checkIn.isBefore(DateTime(now.year, now.month, now.day))) {
        checkInError.value = 'Check-in date cannot be in the past';
        return checkInError.value;
      }
    } catch (e) {
      checkInError.value = 'Invalid date format';
      return checkInError.value;
    }

    checkInError.value = '';
    validateForm();
    return null;
  }

  String? validateCheckOut() {
    final value = checkOutController.text.trim();
    if (value.isEmpty) {
      checkOutError.value = 'Check-out date is required';
      return checkOutError.value;
    }

    try {
      final checkOut = DateTime.parse(value);
      if (checkInController.text.isNotEmpty) {
        final checkIn = DateTime.parse(checkInController.text);
        if (checkOut.isBefore(checkIn.add(const Duration(days: 1)))) {
          checkOutError.value = 'Check-out must be at least 1 day after check-in';
          return checkOutError.value;
        }
      }
    } catch (e) {
      checkOutError.value = 'Invalid date format';
      return checkOutError.value;
    }

    checkOutError.value = '';
    validateForm();
    return null;
  }

  String? validateGuests() {
    final value = guestsController.text.trim();
    if (value.isEmpty) {
      guestsError.value = 'Number of guests is required';
      return guestsError.value;
    }

    final guests = int.tryParse(value);
    if (guests == null || guests < 1 || guests > 4) {
      guestsError.value = 'Guests must be between 1 and 4';
      return guestsError.value;
    }

    guestsError.value = '';
    validateForm();
    return null;
  }

  String? validateName() {
    final value = nameController.text.trim();
    if (value.isEmpty) {
      nameError.value = 'Full name is required';
      return nameError.value;
    }

    if (value.length < 2) {
      nameError.value = 'Name must be at least 2 characters';
      return nameError.value;
    }

    nameError.value = '';
    validateForm();
    return null;
  }

  String? validateEmail() {
    final value = emailController.text.trim();
    if (value.isEmpty) {
      emailError.value = 'Email is required';
      return emailError.value;
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      emailError.value = 'Please enter a valid email address';
      return emailError.value;
    }

    emailError.value = '';
    validateForm();
    return null;
  }

  String? validatePhone() {
    final value = phoneController.text.trim();
    if (value.isEmpty) {
      phoneError.value = 'Phone number is required';
      return phoneError.value;
    }

    final phoneRegex = RegExp(r'^[+]?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      phoneError.value = 'Please enter a valid phone number';
      return phoneError.value;
    }

    phoneError.value = '';
    validateForm();
    return null;
  }

  void validateForm() {
    isFormValid.value = checkInError.value.isEmpty &&
        checkOutError.value.isEmpty &&
        guestsError.value.isEmpty &&
        nameError.value.isEmpty &&
        emailError.value.isEmpty &&
        phoneError.value.isEmpty &&
        checkInController.text.isNotEmpty &&
        checkOutController.text.isNotEmpty &&
        guestsController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  Future<void> submitBooking() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Mock API call
      await Future.delayed(const Duration(seconds: 2));

      final selectedRoom = roomsData.firstWhere(
            (room) => room['id'] == selectedRoomId.value,
        orElse: () => {},
      );

      // Store booking response directly as Map
      final bookingResponse = {
        'bookingId': 'BK${DateTime.now().millisecondsSinceEpoch}',
        'roomId': selectedRoomId.value,
        'roomNumber': selectedRoom['roomNumber'],
        'checkIn': checkInController.text,
        'checkOut': checkOutController.text,
        'guests': int.parse(guestsController.text),
        'guestName': nameController.text,
        'guestEmail': emailController.text,
        'guestPhone': phoneController.text,
        'totalAmount': selectedRoom['price'],
        'status': 'confirmed',
        'bookingDate': DateTime.now().toIso8601String(),
        'hotel': hotelData.value,
        'room': selectedRoom,
      };

      bookingData.value = bookingResponse;

      // Update room availability
      final roomIndex = roomsData.indexWhere((room) => room['id'] == selectedRoomId.value);
      if (roomIndex != -1) {
        roomsData[roomIndex]['isAvailable'] = false;
        roomsData.refresh();
      }

      Get.snackbar(
        'Booking Confirmed',
        'Your room has been booked successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      Get.toNamed('/hotel-room-booking/confirmation');

    } catch (e) {
      errorMessage.value = 'Booking failed: ${e.toString()}';
      Get.snackbar(
        'Booking Failed',
        'Please try again later',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void refreshRooms() {
    fetchRoomsData();
  }

  void clearSelection() {
    selectedRoomId.value = '';
    bookingData.value = null;
  }

  Map<String, dynamic>? getSelectedRoom() {
    if (selectedRoomId.value.isEmpty) return null;

    return roomsData.firstWhere(
          (room) => room['id'] == selectedRoomId.value,
      orElse: () => {},
    );
  }

  double calculateTotalAmount() {
    final selectedRoom = getSelectedRoom();
    if (selectedRoom == null) return 0.0;

    if (checkInController.text.isEmpty || checkOutController.text.isEmpty) {
      return selectedRoom['price'].toDouble();
    }

    try {
      final checkIn = DateTime.parse(checkInController.text);
      final checkOut = DateTime.parse(checkOutController.text);
      final nights = checkOut.difference(checkIn).inDays;

      return (selectedRoom['price'] * nights).toDouble();
    } catch (e) {
      return selectedRoom['price'].toDouble();
    }
  }
}
