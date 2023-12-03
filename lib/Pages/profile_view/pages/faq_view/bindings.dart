import 'package:e_services_fyp/Pages/profile_view/pages/about_us/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/faq_view/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/scheduled_services_view/controller.dart';
import 'package:get/get.dart';

class FAQBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQController>(() => FAQController());
  }

}