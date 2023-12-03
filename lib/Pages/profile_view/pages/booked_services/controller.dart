import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/booked_services/index.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/scheduled_services_view/index.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookedServicesController extends GetxController {
  final state = BookedServicesState();

  BookedServicesController();

  final firestore = FirebaseFirestore.instance
      .collection('bookedServices')
      .where('uid', isEqualTo: SessionController().userId.toString())
      .snapshots();

// cancelOrder(String id) async {
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection('scheduledServices')
//       .doc(id)
//       .delete()
//       .then((value) {
//     print('Order canceled');
//   });
// }
}
