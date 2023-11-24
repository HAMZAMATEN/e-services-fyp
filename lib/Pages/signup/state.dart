import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupState {
  final loading = false.obs;
  final keyboardStatus = false.obs;


  Rx<String> serviceOffering = 'Select'.obs;


  // controllers for login
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // controllers for signUp
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpPhoneController = TextEditingController();

  final signUpUserController = TextEditingController();

  // controllers for service provider signUp
  TextEditingController serviceProviderNameController = TextEditingController();
  TextEditingController serviceProviderEmailController = TextEditingController();
  TextEditingController serviceProviderPhoneNumberController = TextEditingController();
  TextEditingController serviceProviderPassController = TextEditingController();
}