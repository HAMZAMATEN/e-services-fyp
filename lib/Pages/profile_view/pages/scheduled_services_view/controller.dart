import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/scheduled_services_view/index.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ScheduledServicesController extends GetxController {
  final state = ScheduledServicesState();

  ScheduledServicesController();

  final firestore = FirebaseFirestore.instance
      .collection('scheduledServices').where('userId',isEqualTo: SessionController().userId.toString())
      .snapshots();

  cancelOrder(String id) async {
    await FirebaseFirestore.instance
        .collection('scheduledServices')
        .doc(id)
        .delete()
        .then((value) {
      print('Order canceled');
    });
  }
}
