import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginViewController extends GetxController {
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;
  final errorMessage = ''.obs;

  // User data storage (direct Map usage as requested)
  final userData = Rxn<Map<String, dynamic>>();



  // Validation state
  final usernameError = ''.obs;
  final passwordError = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Add listeners for real-time validation
    usernameController.addListener(_validateUsername);
    passwordController.addListener(_validatePassword);
  }

  @override
  void onReady() {
    super.onReady();
    // Clear any previous error messages
    clearErrors();
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Real-time username validation
  void _validateUsername() {
    final username = usernameController.text.trim();

    if (username.isEmpty) {
      usernameError.value = '';
      return;
    }

    if (username.length < 3) {
      usernameError.value = 'Username must be at least 3 characters';
      return;
    }

    // Check if it's an email format
    if (username.contains('@')) {
      if (!GetUtils.isEmail(username)) {
        usernameError.value = 'Please enter a valid email address';
        return;
      }
    }

    usernameError.value = '';
  }

  // Real-time password validation
  void _validatePassword() {
    final password = passwordController.text;

    if (password.isEmpty) {
      passwordError.value = '';
      return;
    }

    if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return;
    }

    passwordError.value = '';
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  // Validate form before submission
  bool _validateForm() {
    bool isValid = true;

    // Validate username
    final username = usernameController.text.trim();
    if (username.isEmpty) {
      usernameError.value = 'Username is required';
      isValid = false;
    } else if (username.length < 3) {
      usernameError.value = 'Username must be at least 3 characters';
      isValid = false;
    } else if (username.contains('@') && !GetUtils.isEmail(username)) {
      usernameError.value = 'Please enter a valid email address';
      isValid = false;
    }

    // Validate password
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    }

    return isValid;
  }

  // Clear all error messages
  void clearErrors() {
    errorMessage.value = '';
    usernameError.value = '';
    passwordError.value = '';
  }

  // Main login function
  Future<void> signIn() async {
    try {
      // Clear previous errors
      clearErrors();

      // Validate form
      if (!_validateForm()) {
        return;
      }

      // Show loading state
      isLoading.value = true;

      // Prepare login data
      final loginData = {
        'username': usernameController.text.trim(),
        'password': passwordController.text,
        'remember_me': rememberMe.value,
        'device_info': {
          'platform': GetPlatform.isAndroid ? 'android' : 'ios',
          'timestamp': DateTime.now().toIso8601String(),
        }
      };

      // Mock API call - Replace with actual API integration
      await Future.delayed(const Duration(seconds: 2));

      // Simulate API response scenarios
      final username = usernameController.text.trim();
      if (username.toLowerCase() == 'admin' && passwordController.text == 'admin123') {
        // Success scenario
        final response = {
          'success': true,
          'user': {
            'id': 1,
            'username': username,
            'email': 'admin@alpanihotel.com',
            'full_name': 'Hotel Administrator',
            'role': 'admin',
            'profile_image': null,
            'last_login': DateTime.now().toIso8601String(),
            'preferences': {
              'theme': 'light',
              'notifications_enabled': true,
            }
          },
          'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
          'expires_in': 3600,
        };

        // Store user data directly as Map
        userData.value = response;

        // Show success message
        Get.snackbar(
          'Welcome Back!',
          'Successfully signed in to Alpani Hotel',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade800,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );

        // Navigate to dashboard or home
        Get.offAllNamed('/dashboard');

      } else {
        // Error scenario
        throw Exception('Invalid username or password');
      }

    } catch (e) {
      // Handle different types of errors
      String errorMsg = 'Login failed. Please try again.';

      if (e.toString().contains('Invalid username or password')) {
        errorMsg = 'Invalid username or password';
      } else if (e.toString().contains('network')) {
        errorMsg = 'Network error. Please check your connection.';
      } else if (e.toString().contains('timeout')) {
        errorMsg = 'Connection timeout. Please try again.';
      }

      errorMessage.value = errorMsg;

      Get.snackbar(
        'Sign In Failed',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
      );

    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to forgot password
  void navigateToForgotPassword() {
    Get.toNamed('/forgot-password');
  }

  // Navigate to registration (if available)
  void navigateToRegister() {
    Get.toNamed('/register');
  }

  // Clear form data
  void clearForm() {
    usernameController.clear();
    passwordController.clear();
    rememberMe.value = false;
    clearErrors();
  }

  // Check if user is remembered (for auto-login)
  void checkRememberedUser() {
    // This would typically check local storage/secure storage
    // For now, it's a placeholder for future implementation

    // Example implementation:
    // final rememberedUsername = GetStorage().read('remembered_username');
    // if (rememberedUsername != null) {
    //   usernameController.text = rememberedUsername;
    //   rememberMe.value = true;
    // }
  }
}
