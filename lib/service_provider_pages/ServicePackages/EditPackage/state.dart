import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

class EditPackageState {
  RxBool infoLoading = true.obs;
  RxBool buttonLoading = false.obs;
  String packageId = "";

  final serviceImage = ''.obs;
  final TextEditingController providerNameController = TextEditingController();
  final TextEditingController providerPhoneController = TextEditingController();
  final TextEditingController providerEmailController = TextEditingController();
  final TextEditingController providerIdController = TextEditingController();
  final TextEditingController providerImageController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();

  // To set
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
}