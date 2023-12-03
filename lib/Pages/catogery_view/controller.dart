import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/catogery_view/state.dart';
import 'package:get/get.dart';

class CatogeryController extends GetxController{
  final state = CatogeryState();
  
  getUserData(String catVal) async {
    await FirebaseFirestore.instance.collection('allServices').where('service' , isEqualTo: catVal).snapshots();

  }


  Future<void> addRating(double rating, String id) async {
    // Replace 'providerId' with the ID of the specific provider document
    DocumentReference providerDocRef =
    FirebaseFirestore.instance.collection('allServices').doc(id);

    // Get current ratings from Firestore and append the new rating to the existing array
    DocumentSnapshot providerDocSnapshot = await providerDocRef.get();
    List<dynamic> ratings =
        (providerDocSnapshot.data() as Map<String, dynamic>)['stars'] ?? [];
    print('object' + ratings.toString());
    ratings.add(rating);

    // Update the 'ratings' array in the provider's document
    await providerDocRef.update({
      'stars': ratings,
    });
  }

  Future<void> getAverageRating(String id) async {
    // Replace 'providerId' with the ID of the specific provider document
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
          double totalRating =
          ratings.reduce((value, element) => value + element);
          state.averageRating.value = totalRating / ratings.length;
        }
      }
    }
  }
}