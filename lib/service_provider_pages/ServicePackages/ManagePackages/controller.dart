import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManagePackageController extends GetxController {
 final serviceRef = FirebaseFirestore.instance.collection('allServices').snapshots();
}