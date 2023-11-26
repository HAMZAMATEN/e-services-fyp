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
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class ScheduledController extends GetxController {
  final state = ScheduledState();
  Set<Marker> markers = {};

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
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('scheduledServices')
            .doc(doc_id)
            .set(scheduledServiceModel.toJson()).then((value) {
              print('object');
        });
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
    state.selectedLatLng.value = LatLng(32.082466, 72.669128);
    state.selectedAddress.value = '';
  }




  void onMapTap(LatLng latLng) async {
    state.selectedLatLng.value = latLng;

    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      state.selectedAddress.value = '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      // You can customize the address format as needed
    }

    if (state.mapController != null) {
      state.mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    }
    updateMarker(latLng);
  }


  void updateMarker(LatLng latLng) {
    markers = {
      Marker(
        markerId: MarkerId('currentLocation'),
        position: latLng,
        infoWindow: InfoWindow(
          title: 'Current Location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      )
    };
  }
  void navigateToCurrentLocation() async {
  LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  print('position' + position.longitude.toString() +"\n"+ position.latitude.toString());

    LatLng latLng = LatLng(position.latitude, position.longitude);

  print('lat lang : ' + latLng.toString());

    state.mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15.0));
    updateMarker(latLng); // Update marker at the current location

    state.selectedLatLng.value = latLng;

    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      state.selectedAddress.value = '${placemark.street}, ${placemark.administrativeArea}, ${placemark.subAdministrativeArea} , ${placemark.country}';
      print('address : '+ state.selectedAddress.value.toString());
    }
  }
}
// void navigateToCurrentLocation() async {
//   print('object12');
//   LocationPermission permission = await Geolocator.requestPermission();
//
//   Position position = await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.medium,
//   );
//   print('position' + position.longitude.toString() +"\n"+ position.latitude.toString());
//
//   LatLng latLng = LatLng(position.latitude, position.longitude);
//
//   print('lat lang : ' + latLng.toString());
//
//   state.mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15.0));
//   updateMarker(latLng); // Update marker at the current location
// }
