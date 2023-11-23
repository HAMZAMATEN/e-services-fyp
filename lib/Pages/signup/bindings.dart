import 'package:e_services_fyp/Pages/signup/controller.dart';
import 'package:get/get.dart';

class SignupBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignupController>(() => SignupController());
  }

}