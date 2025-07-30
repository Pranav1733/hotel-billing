import 'package:get/get.dart';
import '../Controller/login_controller.dart';
import '../Controller/table_management_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {


    // Register all controllers here
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<TableManagementController>(() => TableManagementController());

  }
}
