import 'package:get/get.dart';
import 'package:lmg_todo/application/controller/navbar_controller.dart';
import 'package:lmg_todo/application/controller/todo_controller.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NavbarController(), permanent: true);
    Get.put(TodoController(), permanent: true);
  }
}
