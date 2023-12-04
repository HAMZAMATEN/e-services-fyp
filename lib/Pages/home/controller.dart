import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/home/state.dart';
import 'package:e_services_fyp/Pages/splashScreen/state.dart';
import 'package:e_services_fyp/utils/models/service_package_model.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final state = HomeState();

  @override
  void onInit() {
    // TODO: implement onInit
    fetchUserName();
    super.onInit();
  }

  final firestore =
      FirebaseFirestore.instance.collection('allServices').snapshots();

  Future<void> addRating(double rating, String id) async {
    DocumentReference providerDocRef =
        FirebaseFirestore.instance.collection('allServices').doc(id);

    DocumentSnapshot providerDocSnapshot = await providerDocRef.get();
    List<dynamic> ratings =
        (providerDocSnapshot.data() as Map<String, dynamic>)['stars'] ?? [];
    print('object' + ratings.toString());
    ratings.add(rating);

    await providerDocRef.update({
      'stars': ratings,
    });
  }

  Map<String, RxDouble> serviceAverageRatings = {};

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
          double totalRating =
              ratings.reduce((value, element) => value + element);
          double avgRating = totalRating / ratings.length;

          serviceAverageRatings[id] = avgRating.obs;
          print('rating is:' + avgRating.obs.string);
        }
      }
    }
  }

  fetchUserName() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    if (snapshot.data()!.isEmpty) {
      print('empty');
    } else {
      final data = snapshot.data() as Map<String, dynamic>;
      final name = data['userName'] as String;
      state.userName.value = name;
    }
  }

  Future<List<ServicePackageModel>> getAllServicesData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('allServices').get();
    final servicesData =
        snapshot.docs.map((e) => ServicePackageModel.fromJson(e)).toList();
    print('length:' + servicesData.length.toString());
    return servicesData;
  }

  Future<List<ServicePackageModel>> getAndShowALlServicesData() async {
    return await getAllServicesData();
  }
}
