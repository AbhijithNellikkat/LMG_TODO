import 'package:get/get.dart';
import 'package:lmg_todo/application/controller/todo_controller.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TodoController(), permanent: true);
  }
}
