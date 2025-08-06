// // Create: lib/Middleware/auth_middleware.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Controller/login_view_controller.dart';
// import '../Route Manager/app_routes.dart';
//
// class AuthMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     // Get the login controller if it exists
//     final loginController = Get.isRegistered<LoginViewController>()
//         ? Get.find<LoginViewController>()
//         : null;
//
//     // Check if user is authenticated
//     if (loginController == null || !loginController.isAuthenticated()) {
//       return const RouteSettings(name: AppRoutes.login);
//     }
//
//     // Check role-based routing
//     final userRole = loginController.getCurrentUserRole();
//
//     if (route == AppRoutes.chefDashboard && userRole != 'chef') {
//       // Redirect chef routes to chef dashboard if not chef
//       return const RouteSettings(name: AppRoutes.dashboard);
//     }
//
//     if (route == AppRoutes.dashboard && userRole != 'waiter') {
//       // Redirect waiter routes to waiter dashboard if not waiter
//       return const RouteSettings(name: AppRoutes.chefDashboard);
//     }
//
//     return null; // Continue to the requested route
//   }
// }
//
// class GuestMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     // Get the login controller if it exists
//     final loginController = Get.isRegistered<LoginViewController>()
//         ? Get.find<LoginViewController>()
//         : null;
//
//     // If user is already authenticated, redirect to appropriate dashboard
//     if (loginController != null && loginController.isAuthenticated()) {
//       final userRole = loginController.getCurrentUserRole();
//
//       if (userRole == 'chef') {
//         return const RouteSettings(name: AppRoutes.chefDashboard);
//       } else if (userRole == 'waiter') {
//         return const RouteSettings(name: AppRoutes.dashboard);
//       }
//     }
//
//     return null; // Continue to login
//   }
// }
