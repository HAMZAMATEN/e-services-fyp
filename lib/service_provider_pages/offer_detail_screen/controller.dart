import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/service_provider_pages/offer_detail_screen/state.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OfferDetailController extends GetxController {
  final state = OfferDetailState();
  final ref = FirebaseFirestore.instance.collection('scheduledServices');
  final spRef = FirebaseFirestore.instance.collection('serviceProviders');

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

    // Formatting the DateTime object into a time string
    String formattedTime =
        DateFormat("hh:mm a").format(dateTimeFromMilliseconds);

    return formattedTime;
  }

  Future<void> confirmOrder(String id, String providerId) async {


    try {
      DocumentSnapshot user = await spRef.doc(providerId).get();
      String pName = user['providerName'];
      String pNumber = user['phone'];
      await ref.doc(id).update(
          {
            'provider': providerId,
            'status': 'Confirmed',
          'providerName' : pName,
            'ProviderNumber' : pNumber,
          }).then((value) {
        Snackbar.showSnackBar(
            "Confirmation", "Order Confirmed", Icons.done_all);
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("Error", error.toString(), Icons.error);
      });
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString(), Icons.error);
    }
  }
  Future<void> cancelOrder(String id, String providerId) async {
    try {
      await ref.doc(id).update(
          {
            'provider': '',
            'status': 'Pending',
            'providerName': '',
            'ProviderNumber': '',
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
