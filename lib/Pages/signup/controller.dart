import 'package:e_services_fyp/Pages/signup/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController  extends GetxController with GetTickerProviderStateMixin{
  final state = SignupState();
  late TabController tabController = TabController(length: 2, vsync: this);

}