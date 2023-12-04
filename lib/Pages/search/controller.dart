import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/search/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
  final state = SearchState();
  final auth = FirebaseAuth.instance;

  SearchBarController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<DocumentSnapshot> servicesData = RxList<DocumentSnapshot>();
  RxList<DocumentSnapshot> filteredServicessList = RxList<DocumentSnapshot>();

  // Initialize the controller and fetch data from Firestore
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Fetch data from Firestore
  void fetchData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('allServices').get();

    print('Snapshot is : ' + querySnapshot.toString());
    servicesData.assignAll(querySnapshot.docs);
  }

  // Search for tours based on a query
  void searchServices(String query) {
    final lowerCaseQuery = query.toLowerCase();
    List<DocumentSnapshot> results = [];
    if (query.isEmpty) {
      results = [];
    } else {
      results = servicesData
          .where((ele) =>
              ele['service'].toString().toLowerCase().contains(lowerCaseQuery) ||
              ele['description']
                  .toString()
                  .toLowerCase()
                  .contains(lowerCaseQuery) ||
              ele['providerName']
                  .toString()
                  .toLowerCase()
                  .contains(lowerCaseQuery) ||
              ele['hourlyRate']
                  .toString()
                  .toLowerCase()
                  .contains(lowerCaseQuery))
          .toList();
    }
    filteredServicessList.value = results;
    update();
  }



  Future<void> addRating(double rating, String id) async {
    DocumentReference providerDocRef =
    FirebaseFirestore.instance.collection('allServices').doc(id);

    DocumentSnapshot providerDocSnapshot = await providerDocRef.get();
    List<dynamic> ratings =
        (providerDocSnapshot.data() as Map<String, dynamic>)['stars'] ?? [];
    print('object'+ratings.toString());
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
          double totalRating = ratings.reduce((value, element) => value + element);
          double avgRating = totalRating / ratings.length;

          serviceAverageRatings[id] = avgRating.obs;
          print('rating is:'+avgRating.obs.string);
        }
      }
    }
  }
}
