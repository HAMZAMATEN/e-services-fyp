import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:get/get.dart';

class ManagePackageController extends GetxController {
 // String pId = SessionController().userId.toString();
 final serviceRef = FirebaseFirestore.instance.collection('allServices').where('providerId',isEqualTo : SessionController().userId.toString()).snapshots();
}