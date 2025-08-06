import 'package:get/get.dart';
import '../Auth/login_view.dart';
import '../View/TableManagementView/table_management_view.dart';
import '../View/TableManagementView/widgets/add_items_page.dart';
import '../View/TableManagementView/widgets/customer_detail_page.dart';
import '../View/chef_pannel/order_management_view.dart';
import 'app_bindings.dart';

class AppRoutes {
  // Route names
  static const login = '/login';

// lib/routes/app_routes.dart
  static const waiterDashboard = '/dashboard';
  static const customerDetails = '/customer-details';
  static const addItems = '/add-items';
  static const orderSummary = '/order-summary';
  static const tableDetails = '/table-details';
  static const settings = '/settings';
  static const reports = '/reports';
  static const chefDashboard = '/chef-dashboard';



  static final routes = <GetPage>[

    GetPage(
      name: login,
      page: () =>  LoginScreen(),
      binding: AppBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),

    ), // Dashboard route
    GetPage(
      name: AppRoutes.waiterDashboard,
      page: () =>  TableManagementView(),
      binding: AppBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.chefDashboard,
      page: () =>  OrderManagementView(),
      binding: AppBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Customer details route
    GetPage(
      name: AppRoutes.customerDetails,
      page: () => const CustomerDetailPage(),
      binding: AppBindings(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Add items route
    GetPage(
      name: AppRoutes.addItems,
      page: () => const AddItemsPage(),
      binding: AppBindings(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Order summary route (optional additional page)
    // GetPage(
    //   name: AppRoutes.orderSummary,
    //   page: () => const OrderSummaryPage(),
    //   binding: AppBindings(),
    //   transition: Transition.rightToLeft,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    //
    // // Table details route (for viewing occupied table details)
    // GetPage(
    //   name: AppRoutes.tableDetails,
    //   page: () => const TableDetailsPage(),
    //   binding: AppBindings(),
    //   transition: Transition.rightToLeft,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
  


  ];
}
