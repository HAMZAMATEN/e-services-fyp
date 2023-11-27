import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/service_provider_pages/shedule_offers/state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class ScheduleOffersController extends GetxController {
final state = ScheduleOffersState();
final ref= FirebaseFirestore.instance.collection('scheduledServices').where('status' , isEqualTo: 'Pending').snapshots();


}