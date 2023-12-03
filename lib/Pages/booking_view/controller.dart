import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/booking_view/state.dart';
import 'package:e_services_fyp/utils/models/booking_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/compnents/snackbar_widget.dart';
import 'bookings_success_screen/view.dart';

class BookingController extends GetxController {
  final state = BookingState();

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentUserData();
    super.onInit();
  }

  Set<Marker> markers = {};

  setLoading(value) {
    state.loading.value = value;
  }

  final firestore =
      FirebaseFirestore.instance.collection('allServices').snapshots();

  Future<void> addRating(double rating, String id) async {
    // Replace 'providerId' with the ID of the specific provider document
    DocumentReference providerDocRef =
        FirebaseFirestore.instance.collection('allServices').doc(id);

    // Get current ratings from Firestore and append the new rating to the existing array
    DocumentSnapshot providerDocSnapshot = await providerDocRef.get();
    List<dynamic> ratings =
        (providerDocSnapshot.data() as Map<String, dynamic>)['stars'] ?? [];
    print('object' + ratings.toString());
    ratings.add(rating);

    // Update the 'ratings' array in the provider's document
    await providerDocRef.update({
      'stars': ratings,
    });
  }

  Future<void> getAverageRating(String id) async {
    // Replace 'providerId' with the ID of the specific provider document
    DocumentSnapshot providerDocSnapshot = await FirebaseFirestore.instance
        .collection('allServices')
        .doc(id)
        .get();

    if (providerDocSnapshot.exists) {
      Map<String, dynamic>? data =
          providerDocSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('stars')) {
        List<dynamic> ratings = data['stars'] ?? [];

        if (ratings.isNotEmpty) {
          double totalRating =
              ratings.reduce((value, element) => value + element);
          state.averageRating.value = totalRating / ratings.length;
        }
      }
    }
  }

  void getCurrentUserData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      state.name = data['userName'].toString();
      state.phone = data['phone'].toString();
    }
  }

  void getCurrentServiceData(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('allServices')
        .doc(id)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      // print('object' + data['providerName']);
      state.providerName.value = data['providerName'].toString();
      state.providerPhone.value = data['providerPhone'].toString();
      state.service.value = data['service'].toString();
      state.price.value = data['hourlyRate'].toString();
      state.description.value = data['description'].toString();
      state.imageURl.value = data['imageUrl'].toString();
      state.providerImageUrl.value = data['providerImageUrl'].toString();
    }
  }

  void onMapTap(LatLng latLng) async {
    state.selectedLatLng.value = latLng;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      state.selectedAddress.value =
          '${placemark.street}, ${placemark.locality}, ${placemark.country}';
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
    print('position' +
        position.longitude.toString() +
        "\n" +
        position.latitude.toString());

    LatLng latLng = LatLng(position.latitude, position.longitude);

    print('lat lang : ' + latLng.toString());

    state.mapController
        ?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15.0));
    updateMarker(latLng); // Update marker at the current location

    state.selectedLatLng.value = latLng;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      state.selectedAddress.value =
          '${placemark.street}, ${placemark.administrativeArea}, ${placemark.subAdministrativeArea} , ${placemark.country}';
      print('address : ' + state.selectedAddress.value.toString());
    }
  }

  storeDataInFirebase(BookingModel bookingModel,String id) async {
    setLoading(true);
    try {
      print('try');

      String doc_id = DateTime.now().millisecondsSinceEpoch.toString();
      bookingModel.id = doc_id;
      print('try:' + doc_id);

      await FirebaseFirestore.instance
          .collection('bookedServices')
          .doc(doc_id)
          .set(bookingModel.toJson())
          .then((value) {
            checkAlreadyBooked(id);
        print('success');
        Snackbar.showSnackBar(
            'Success', "Successfully scheduled.", Icons.done_all);
        Get.to(
          SuccessfulView(),
        );
        setLoading(false);
      }).onError((error, stackTrace) {
        print('error');
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
    }
  }

  checkAlreadyBooked(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('allServices')
        .doc(id).update({
      'isBooked' : true,
    }).then((value) {
      print('updated success');
    });

  }


}
