import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/controller.dart';
import 'package:e_services_fyp/Pages/scheduled_view/controller.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ApplicationBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ScheduledController>(() => ScheduledController());

  }

}