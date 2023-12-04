import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/booking_view/controller.dart';
import 'package:e_services_fyp/Pages/scheduled_view/controller.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../res/colors.dart';
import '../../../../res/text_widget.dart';


class LocationSelectionScreenBooking extends GetView<BookingController> {
// Define an observable for selectedAddress

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Select Location',
          fontSize: 20,
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => GoogleMap(
              onMapCreated: (con) {
                controller.state.mapController = con;
              },
              onTap: controller.onMapTap,
              markers: controller.markers,
              initialCameraPosition: CameraPosition(
                target: controller.state.selectedLatLng.value,
                // Use the value of selectedLatLng
                zoom: 12.0,
              ),
            )),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.iconsColor),
            ),
            onPressed: () async {
              if (controller.state.selectedLatLng.value != LatLng(0, 0) &&
                  controller.state.selectedAddress.value.isNotEmpty) {
                // await _saveLocationToFirestore(controller.state.selectedLatLng.value, controller.state.selectedAddress.value);
                Get.back();
                Snackbar.showSnackBar(
                    'Success', 'Successfully select location', Icons.done_all);
              } else {
                Snackbar.showSnackBar(
                  'Error',
                  'Please select a location on the map',
                  Icons.error_outline_outlined,
                );
              }
            },
            child: TextWidget(title: 'Save Location'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToCurrentLocationBooking,
        backgroundColor: AppColors.iconsColor,
        child: Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
      ),
    );
  }
}
