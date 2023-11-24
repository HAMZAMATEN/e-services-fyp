import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ScheduledState {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  Rx<LatLng> selectedLocation = LatLng(32.082466, 72.669128).obs;

  final nameCon = TextEditingController();
  final phoneCon = TextEditingController();
  final addCon = TextEditingController();
  final serviceNameCon = TextEditingController();
  final timeCon = TextEditingController();

}