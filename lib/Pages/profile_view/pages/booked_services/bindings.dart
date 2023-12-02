import 'package:e_services_fyp/Pages/profile_view/pages/booked_services/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/scheduled_services_view/controller.dart';
import 'package:get/get.dart';

class BookedServicesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookedServicesController>(() => BookedServicesController());
  }

}