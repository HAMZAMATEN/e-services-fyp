import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/service_provider_pages/drawer/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  final state = DrawerState();

  @override
  void onInit() {
    // TODO: implement onInit
    fetchUserName();
    super.onInit();
  }

  fetchUserName() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('serviceProviders')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    if (snapshot.data()!.isEmpty) {
      print('empty');
    } else {
      final data = snapshot.data() as Map<String, dynamic>;
      final name = data['providerName'] as String;
      state.userName.value = name;
    }
  }
}
