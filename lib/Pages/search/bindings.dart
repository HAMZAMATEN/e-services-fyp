import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SearchBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SearchBarController>(() => SearchBarController());
  }

}