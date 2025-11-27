import 'package:get/get.dart';
import 'package:lmg_todo/todo%20app%20/application/controller/navbar_controller.dart';
import 'package:lmg_todo/todo%20app%20/application/controller/todo_controller.dart';
import 'package:lmg_todo/todo%20app%20/application/controller/todo_details_controller.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NavbarController(), permanent: true);
    Get.put(TodoController(), permanent: true);
    // Get.put(TodoController(), permanent: true);
    Get.lazyPut(() => TodoDetailsController(), fenix: true);
  }
}
