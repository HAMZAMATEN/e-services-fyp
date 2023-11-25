import 'package:e_services_fyp/Pages/catogery_view/controller.dart';
import 'package:get/get.dart';

class CatogeryBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CatogeryController>(() => CatogeryController());
  }

}