import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/booking_view/state.dart';
import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/utils/prefrences/storage_prefs.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final state = BookingState();

  final firestore = FirebaseFirestore.instance.collection('allServices').snapshots();
}