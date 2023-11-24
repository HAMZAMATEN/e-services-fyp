import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/home/state.dart';
import 'package:e_services_fyp/Pages/profile_view/state.dart';
import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  final state = ProfileState();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();
  }

}