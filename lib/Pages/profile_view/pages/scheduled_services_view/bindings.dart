import 'package:e_services_fyp/Pages/profile_view/pages/scheduled_services_view/controller.dart';
import 'package:get/get.dart';

class ScheduledServicesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduledServicesController>(() => ScheduledServicesController());
  }

}