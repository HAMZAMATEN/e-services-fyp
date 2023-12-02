import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingState {
  RxDouble averageRating = 0.0.obs;
  String name = '';
  String phone = '';
  RxString providerName = ''.obs;
  RxString providerPhone = ''.obs;
  RxString service = ''.obs;
  RxString description = ''.obs;
  RxString price = ''.obs;
  final addressCon = TextEditingController();
  RxBool loading = false.obs;


  final selectedLatLng = LatLng(32.082466, 72.669128).obs; // Define an observable for selectedLatLng
  final selectedAddress = ''.obs;
  GoogleMapController? mapController;
}