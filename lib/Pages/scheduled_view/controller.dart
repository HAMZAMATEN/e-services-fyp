import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:e_services_fyp/Pages/home/state.dart';
import 'package:e_services_fyp/Pages/scheduled_view/state.dart';
import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:e_services_fyp/utils/models/scheduled_Service_model.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class ScheduledController extends GetxController {
  final state = ScheduledState();

  void selectLocation(LatLng location) {
    state.selectedLocation.value = location;
  }

  setLoading(value) {
    state.loading.value = value;
  }

  getDateFromUser(BuildContext context) async {
    final date = await showDatePickerDialog(
      context: context,
      initialDate: DateTime.now(),
      minDate: DateTime(1900, 1, 1),
      maxDate: DateTime(2121, 12, 31),
      selectedCellColor: AppColors.iconsColor,
      slidersColor: AppColors.iconsColor,
      currentDateColor: AppColors.iconsColor,
      highlightColor: AppColors.iconsColor,
    );
    if (date != null) {
      state.selectedDate.value = date;
    } else {
      print('its null');
    }
  }

  getTimeFromUser(BuildContext context) async {
    final _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 00),
    );
    String formattedTime = _pickedTime!.format(context);
    if (formattedTime != '') {
      state.selectedTime.value = formattedTime;
      print(formattedTime);
    } else {
      print('its null');
    }
  }

  storeDataInFirebase(ScheduledServiceModel scheduledServiceModel) async {
    try {
      setLoading(true);
      String doc_id = DateTime.now().millisecondsSinceEpoch.toString();
      scheduledServiceModel.id = doc_id;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('scheduledServices')
          .doc(doc_id)
          .set(scheduledServiceModel.toJson())
          .then((value) {
        print('success');
        clearValues();
        Snackbar.showSnackBar(
            'Success', "Successfully scheduled.", Icons.done_all);
        setLoading(false);
      }).onError((error, stackTrace) {
        print('error');
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
    }
  }

  clearValues() {
    state.nameCon.clear();
    state.serviceNameCon.clear();
    state.phoneCon.clear();
    state.addCon.clear();
    state.serviceOffering.value = '';
    state.selectedDate.value = DateTime.now();
    state.selectedTime.value =
        DateFormat("hh:mm a").format(DateTime.now()).toString();
  }


}
