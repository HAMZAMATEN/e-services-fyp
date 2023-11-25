import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';


class ScheduledState {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedTime = DateFormat("hh:mm a").format(DateTime.now()).toString().obs;
  Rx<LatLng> selectedLocation = LatLng(32.082466, 72.669128).obs;

  Rx<String> serviceOffering = 'Select'.obs;

  RxBool loading = false.obs;


  final nameCon = TextEditingController();
  final phoneCon = TextEditingController();
  final addCon = TextEditingController();
  final serviceNameCon = TextEditingController();
  final timeCon = TextEditingController();


}