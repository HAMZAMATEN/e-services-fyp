import 'package:e_services_fyp/Pages/scheduled_view/controller.dart';
import 'package:get/get.dart';

class ScheduledBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScheduledController>(() => ScheduledController());
  }

}