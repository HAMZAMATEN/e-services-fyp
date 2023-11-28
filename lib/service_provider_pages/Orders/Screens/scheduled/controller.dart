import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/scheduled_view/state.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduledOrdersController extends GetxController {
  final state = ScheduledState();
  final ref = FirebaseFirestore.instance.collection('scheduledServices').where('provider', isEqualTo: SessionController().userId.toString()).snapshots();
  final orderRef = FirebaseFirestore.instance.collection('scheduledServices');

  String convertMillisecondsToDateFormat(String millisec) {
    int milliseconds = int.parse(millisec);
    // Convert milliseconds to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    // Extract day, month, and year
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    // Format the date as "DD:MM:YYYY"
    String formattedDate = '$day:${month.toString().padLeft(2, '0')}:$year';

    return formattedDate;
  }

  String convertTime(String time) {
    int milliseconds = int.parse(time);
    DateTime dateTimeFromMilliseconds =
    DateTime.fromMillisecondsSinceEpoch(milliseconds);
    print(dateTimeFromMilliseconds.toString()+"dtime");
    // Formatting the DateTime object into a time string
    String formattedTime =
    DateFormat("hh:mm a").format(dateTimeFromMilliseconds);
    print(formattedTime.toString() + "dtime");
    return formattedTime;

    // return formattedTime;
  }

  Future<void> cancelOrder(String id, String providerId) async {
    try {
      await orderRef.doc(id).update(
          {'provider': '',
            'status': 'Pending'
          }).then((value) {
        Snackbar.showSnackBar(
            "Confirmation", "Order Cancelled", Icons.done_all);
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("Error", error.toString(), Icons.error);
      });
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString(), Icons.error);
    }
  }

}