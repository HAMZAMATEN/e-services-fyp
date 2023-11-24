import 'package:e_services_fyp/Pages/home/state.dart';
import 'package:e_services_fyp/Pages/scheduled_view/state.dart';
import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScheduledController extends GetxController{
  final state = ScheduledState();


  void selectDate(DateTime date) {
    state.selectedDate.value = date;
  }

  void selectTime(TimeOfDay time) {
    state.selectedTime.value = time;
  }

  void selectLocation(LatLng location) {
    state.selectedLocation.value = location;
  }

}