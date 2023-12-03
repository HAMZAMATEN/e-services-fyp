import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/home/state.dart';
import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final state = HomeState();


  @override
  void onInit() {
    // TODO: implement onInit
    checkAlreadyBooked();
    super.onInit();
  }


  final firestore =
  FirebaseFirestore.instance.collection('allServices').snapshots();


  Future<void> addRating(double rating, String id) async {
    // Replace 'providerId' with the ID of the specific provider document
    DocumentReference providerDocRef =
    FirebaseFirestore.instance.collection('allServices').doc(id);

    // Get current ratings from Firestore and append the new rating to the existing array
    DocumentSnapshot providerDocSnapshot = await providerDocRef.get();
    List<dynamic> ratings =
        (providerDocSnapshot.data() as Map<String, dynamic>)['stars'] ?? [];
    print('object'+ratings.toString());
    ratings.add(rating);

    // Update the 'ratings' array in the provider's document
    await providerDocRef.update({
      'stars': ratings,
    });
  }
  // Define a map to store average ratings for different services
  Map<String, RxDouble> serviceAverageRatings = {};

// Function to get average rating for a specific service
  Future<void> getAverageRating(String id) async {
    DocumentSnapshot providerDocSnapshot = await FirebaseFirestore.instance
        .collection('allServices')
        .doc(id)
        .get();

    if (providerDocSnapshot.exists) {
      Map<String, dynamic>? data =
      providerDocSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('stars')) {
        List<dynamic> ratings = data['stars'] ?? [];

        if (ratings.isNotEmpty) {
          double totalRating = ratings.reduce((value, element) => value + element);
          double avgRating = totalRating / ratings.length;

          // Store the average rating in the map with the service ID as the key
          serviceAverageRatings[id] = avgRating.obs;
          print('rating is:'+avgRating.obs.string);
        }
      }
    }
  }

  checkAlreadyBooked() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('bookedServices')
        .where('uid',
        isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    if (snapshot.docs.isEmpty) {
      print('empty');
    } else {
      print('length : ' + snapshot.docs.length.toString());
      for (var i in snapshot.docs) {
        var uid = i.get('uid');
        if (uid != null && uid is String) {
          state.uid.add(uid);
        }
      }
    }
  }

  bool checkIfExists(String uidToCheck) {
    // Check if uidToCheck exists in uidList
    return state.uid.contains(uidToCheck);
  }

}