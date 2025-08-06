// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:setuapp/Route%20Manager/app_routes.dart';
//
// class LoginViewController extends GetxController {
//   // Form key for validation
//   final formKey = GlobalKey<FormState>();
//
//   // Text editing controllers
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   // Observable variables
//   final isLoading = false.obs;
//   final isPasswordVisible = false.obs;
//   final rememberMe = false.obs;
//   final errorMessage = ''.obs;
//
//   // User data storage (direct Map usage as requested)
//   final userData = Rxn<Map<String, dynamic>>();
//
//
//
//   // Validation state
//   final usernameError = ''.obs;
//   final passwordError = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     // Add listeners for real-time validation
//     usernameController.addListener(_validateUsername);
//     passwordController.addListener(_validatePassword);
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//     // Clear any previous error messages
//     clearErrors();
//   }
//
//   @override
//   void onClose() {
//     // Dispose controllers to prevent memory leaks
//     usernameController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
//
//   // Real-time username validation
//   void _validateUsername() {
//     final username = usernameController.text.trim();
//
//     if (username.isEmpty) {
//       usernameError.value = '';
//       return;
//     }
//
//     if (username.length < 3) {
//       usernameError.value = 'Username must be at least 3 characters';
//       return;
//     }
//
//     // Check if it's an email format
//     if (username.contains('@')) {
//       if (!GetUtils.isEmail(username)) {
//         usernameError.value = 'Please enter a valid email address';
//         return;
//       }
//     }
//
//     usernameError.value = '';
//   }
//
//   // Real-time password validation
//   void _validatePassword() {
//     final password = passwordController.text;
//
//     if (password.isEmpty) {
//       passwordError.value = '';
//       return;
//     }
//
//     if (password.length < 6) {
//       passwordError.value = 'Password must be at least 6 characters';
//       return;
//     }
//
//     passwordError.value = '';
//   }
//
//   // Toggle password visibility
//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }
//
//   // Toggle remember me
//   void toggleRememberMe(bool? value) {
//     rememberMe.value = value ?? false;
//   }
//
//   // Validate form before submission
//   bool _validateForm() {
//     bool isValid = true;
//
//     // Validate username
//     final username = usernameController.text.trim();
//     if (username.isEmpty) {
//       usernameError.value = 'Username is required';
//       isValid = false;
//     } else if (username.length < 3) {
//       usernameError.value = 'Username must be at least 3 characters';
//       isValid = false;
//     } else if (username.contains('@') && !GetUtils.isEmail(username)) {
//       usernameError.value = 'Please enter a valid email address';
//       isValid = false;
//     }
//
//     // Validate password
//     final password = passwordController.text;
//     if (password.isEmpty) {
//       passwordError.value = 'Password is required';
//       isValid = false;
//     } else if (password.length < 6) {
//       passwordError.value = 'Password must be at least 6 characters';
//       isValid = false;
//     }
//
//     return isValid;
//   }
//
//   // Clear all error messages
//   void clearErrors() {
//     errorMessage.value = '';
//     usernameError.value = '';
//     passwordError.value = '';
//   }
//
//   // Main login function
//   Future<void> signIn() async {
//     try {
//       // Clear previous errors
//       clearErrors();
//
//       // Validate form
//       if (!_validateForm()) {
//         return;
//       }
//
//       // Show loading state
//       isLoading.value = true;
//
//       // Prepare login data
//       final loginData = {
//         'username': usernameController.text.trim(),
//         'password': passwordController.text,
//         'remember_me': rememberMe.value,
//         'device_info': {
//           'platform': GetPlatform.isAndroid ? 'android' : 'ios',
//           'timestamp': DateTime.now().toIso8601String(),
//         }
//       };
//
//       // Mock API call - Replace with actual API integration
//       await Future.delayed(const Duration(seconds: 2));
//
//       // Simulate API response scenarios
//       final username = usernameController.text.trim();
//       if (username.toLowerCase() == 'admin' && passwordController.text == 'admin123') {
//         // Success scenario
//         final response = {
//           'success': true,
//           'user': {
//             'id': 1,
//             'username': username,
//             'email': 'admin@alpanihotel.com',
//             'full_name': 'Hotel Administrator',
//             'role': 'admin',
//             'profile_image': null,
//             'last_login': DateTime.now().toIso8601String(),
//             'preferences': {
//               'theme': 'light',
//               'notifications_enabled': true,
//             }
//           },
//           'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
//           'expires_in': 3600,
//         };
//
//         // Store user data directly as Map
//         userData.value = response;
//
//         // Show success message
//         Get.snackbar(
//           'Welcome Back!',
//           'Successfully signed in to Alpani Hotel',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade100,
//           colorText: Colors.green.shade800,
//           duration: const Duration(seconds: 3),
//           margin: const EdgeInsets.all(16),
//         );
//
//         // Navigate to dashboard of waiter
//         Get.offAllNamed(AppRoutes.dashboard);
//         // Navigate to dashboard of chef
//         Get.offAllNamed(AppRoutes.chefDashboard);
//
//       } else {
//         // Error scenario
//         throw Exception('Invalid username or password');
//       }
//
//     } catch (e) {
//       // Handle different types of errors
//       String errorMsg = 'Login failed. Please try again.';
//
//       if (e.toString().contains('Invalid username or password')) {
//         errorMsg = 'Invalid username or password';
//       } else if (e.toString().contains('network')) {
//         errorMsg = 'Network error. Please check your connection.';
//       } else if (e.toString().contains('timeout')) {
//         errorMsg = 'Connection timeout. Please try again.';
//       }
//
//       errorMessage.value = errorMsg;
//
//       Get.snackbar(
//         'Sign In Failed',
//         errorMsg,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade100,
//         colorText: Colors.red.shade800,
//         duration: const Duration(seconds: 4),
//         margin: const EdgeInsets.all(16),
//       );
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Navigate to forgot password
//   void navigateToForgotPassword() {
//     Get.toNamed('/forgot-password');
//   }
//
//   // Navigate to registration (if available)
//   void navigateToRegister() {
//     Get.toNamed('/register');
//   }
//
//   // Clear form data
//   void clearForm() {
//     usernameController.clear();
//     passwordController.clear();
//     rememberMe.value = false;
//     clearErrors();
//   }
//
//   // Check if user is remembered (for auto-login)
//   void checkRememberedUser() {
//     // This would typically check local storage/secure storage
//     // For now, it's a placeholder for future implementation
//
//     // Example implementation:
//     // final rememberedUsername = GetStorage().read('remembered_username');
//     // if (rememberedUsername != null) {
//     //   usernameController.text = rememberedUsername;
//     //   rememberMe.value = true;
//     // }
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:setuapp/Route%20Manager/app_routes.dart';

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

  // Get mock user data based on credentials
  Map<String, dynamic>? _getMockUserData(String username, String password) {
    try {
      // Mock database - Replace with actual API call
      final mockUsers = <String, Map<String, dynamic>>{
        'chef': {
          'password': 'chef123',
          'user': {
            'id': 1,
            'username': 'chef',
            'email': 'chef@alpanihotel.com',
            'full_name': 'Head Chef',
            'role': 'chef',
            'profile_image': null,
            'last_login': DateTime.now().toIso8601String(),
            'preferences': {
              'theme': 'light',
              'notifications_enabled': true,
            }
          }
        },
        'waiter': {
          'password': 'waiter123',
          'user': {
            'id': 2,
            'username': 'waiter',
            'email': 'waiter@alpanihotel.com',
            'full_name': 'Senior Waiter',
            'role': 'waiter',
            'profile_image': null,
            'last_login': DateTime.now().toIso8601String(),
            'preferences': {
              'theme': 'light',
              'notifications_enabled': true,
            }
          }
        },
        'chef2': {
          'password': 'chef456',
          'user': {
            'id': 3,
            'username': 'chef2',
            'email': 'chef2@alpanihotel.com',
            'full_name': 'Assistant Chef',
            'role': 'chef',
            'profile_image': null,
            'last_login': DateTime.now().toIso8601String(),
            'preferences': {
              'theme': 'dark',
              'notifications_enabled': false,
            }
          }
        },
        'waiter2': {
          'password': 'waiter456',
          'user': {
            'id': 4,
            'username': 'waiter2',
            'email': 'waiter2@alpanihotel.com',
            'full_name': 'Junior Waiter',
            'role': 'waiter',
            'profile_image': null,
            'last_login': DateTime.now().toIso8601String(),
            'preferences': {
              'theme': 'light',
              'notifications_enabled': true,
            }
          }
        }
      };

      print('Attempting login with username: $username'); // Debug print

      // Use lowercase for case-insensitive comparison
      final user = mockUsers[username.toLowerCase()];

      if (user == null) {
        print('User not found: $username'); // Debug print
        return null;
      }

      final storedPassword = user['password'] as String?;
      print('Password check - Input: $password, Expected: $storedPassword'); // Debug print

      if (storedPassword == password) {
        print('Login successful for user: $username'); // Debug print
        return {
          'success': true,
          'user': user['user'],
          'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
          'expires_in': 3600,
        };
      } else {
        print('Password mismatch for user: $username'); // Debug print
        return null;
      }
    } catch (e) {
      print('Error in _getMockUserData: $e'); // Debug print
      return null;
    }
  }

  // Navigate based on user role
  void _navigateBasedOnRole(String role) {
    try {
      switch (role.toLowerCase()) {
        case 'chef':
          Get.offAllNamed(AppRoutes.chefDashboard);
          break;
        case 'waiter':
          Get.offAllNamed(AppRoutes.waiterDashboard);
          break;
        default:
        // Fallback to chef dashboard
          Get.offAllNamed(AppRoutes.chefDashboard);
          break;
      }
    } catch (e) {
      print('Navigation error: $e');
      // Fallback navigation
      Get.offAllNamed('/dashboard'); // or whatever your default route is
    }
  }

  // Get success message based on role
  String _getWelcomeMessage(String role, String fullName) {
    switch (role.toLowerCase()) {
      case 'chef':
        return 'Welcome to the Kitchen, Chef!';
      case 'waiter':
        return 'Ready to serve, $fullName!';
      default:
        return 'Welcome back!';
    }
  }

  // Main login function
  Future<void> signIn() async {
    try {
      // Clear previous errors
      clearErrors();

      // Validate form
      if (!_validateForm()) {
        print('Form validation failed'); // Debug print
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

      print('Login attempt: ${loginData['username']}'); // Debug print

      // Mock API call - Replace with actual API integration
      await Future.delayed(const Duration(seconds: 1)); // Reduced delay for better UX

      // Get user data from mock database
      final response = _getMockUserData(
        usernameController.text.trim(),
        passwordController.text,
      );

      print('Mock API response: $response'); // Debug print

      if (response != null && response['success'] == true) {
        // Store user data directly as Map
        userData.value = response;

        final user = response['user'] as Map<String, dynamic>;
        final userRole = user['role'] as String;
        final fullName = user['full_name'] as String;

        print('Login successful for role: $userRole'); // Debug print

        // Show success message based on role
        Get.snackbar(
          _getWelcomeMessage(userRole, fullName),
          'Successfully signed in to Alpani Hotel',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade800,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          icon: Icon(
            _getRoleIcon(userRole),
            color: Colors.green.shade800,
          ),
        );

        // Small delay to show success message
        await Future.delayed(const Duration(milliseconds: 500));

        // Navigate based on user role
        _navigateBasedOnRole(userRole);

      } else {
        // Error scenario
        throw Exception('Invalid username or password');
      }

    } catch (e) {
      print('Sign in error: $e'); // Debug print

      // Handle different types of errors
      String errorMsg = 'Login failed. Please try again.';

      if (e.toString().contains('Invalid username or password')) {
        errorMsg = 'Invalid username or password. Please check your credentials.';
      } else if (e.toString().contains('network')) {
        errorMsg = 'Network error. Please check your connection.';
      } else if (e.toString().contains('timeout')) {
        errorMsg = 'Connection timeout. Please try again.';
      }

      errorMessage.value = errorMsg;

      Get.snackbar(
        'Sign In Failed',
        errorMsg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
        icon: Icon(
          Icons.error_outline,
          color: Colors.red.shade800,
        ),
      );

    } finally {
      isLoading.value = false;
    }
  }
  // In your LoginViewController, update the signIn method:

// Also add this method to fix logout
  void logout() {
    userData.value = null;
    clearForm();
    Get.offAllNamed(AppRoutes.login);

    Get.snackbar(
      'Logged Out',
      'You have been successfully logged out',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.shade100,
      colorText: Colors.blue.shade800,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
    );
  }


  // Get icon based on role
  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'chef':
        return Icons.restaurant;
      case 'waiter':
        return Icons.room_service;
      default:
        return Icons.person;
    }
  }

  // Get current user role
  String? getCurrentUserRole() {
    if (userData.value != null && userData.value!['user'] != null) {
      final user = userData.value!['user'] as Map<String, dynamic>;
      return user['role'] as String?;
    }
    return null;
  }

  // Get current user data
  Map<String, dynamic>? getCurrentUser() {
    if (userData.value != null && userData.value!['user'] != null) {
      return userData.value!['user'] as Map<String, dynamic>?;
    }
    return null;
  }

  // Check if user has specific role
  bool hasRole(String role) {
    final currentRole = getCurrentUserRole();
    return currentRole != null && currentRole.toLowerCase() == role.toLowerCase();
  }

  // Check if user is authenticated
  bool isAuthenticated() {
    return userData.value != null &&
        userData.value!['token'] != null &&
        userData.value!['user'] != null;
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

  // Helper method to get mock credentials for testing
  void fillMockCredentials(String userType) {
    clearForm();
    switch (userType.toLowerCase()) {
      case 'chef':
        usernameController.text = 'chef';
        passwordController.text = 'chef123';
        break;
      case 'waiter':
        usernameController.text = 'waiter';
        passwordController.text = 'waiter123';
        break;
      case 'chef2':
        usernameController.text = 'chef2';
        passwordController.text = 'chef456';
        break;
      case 'waiter2':
        usernameController.text = 'waiter2';
        passwordController.text = 'waiter456';
        break;
    }
  }
}