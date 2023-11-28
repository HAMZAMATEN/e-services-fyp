import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/service_provider_pages/shedule_offers/state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduleOffersController extends GetxController {
  final state = ScheduleOffersState();
  final ref = FirebaseFirestore.instance
      .collection('scheduledServices')
      .where('status', isEqualTo: 'Pending')
      .snapshots();

  String convertMillisecondsToHrsMM(String millisec) {
    int milliseconds = int.parse(millisec);
// Check if the time is negative (before 12:00 AM)
    bool isNegative = milliseconds < 0;

    // Take the absolute value for calculations
    int absMilliseconds = isNegative ? -milliseconds : milliseconds;

    // Convert milliseconds to seconds
    int seconds = (absMilliseconds / 1000).round();

    // Calculate hours, minutes, and seconds
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;

    // Format the time as "Hrs:MM"
    String formattedTime = '$hours:${minutes.toString().padLeft(2, '0')}';

    // Add a negative sign if necessary
    if (isNegative) {
      formattedTime = '-$formattedTime';
    }

    return formattedTime;
  }

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
}
