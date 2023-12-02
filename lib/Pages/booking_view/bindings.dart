import 'package:e_services_fyp/Pages/booking_view/controller.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:get/get.dart';

class BookingBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<BookingController>(() => BookingController());
  }

}