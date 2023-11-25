import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/signup/state.dart';
import 'package:e_services_fyp/utils/models/service_provide_model.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/compnents/snackbar_widget.dart';
import '../../utils/models/user_model.dart';
import '../../utils/prefrences/storage_prefs.dart';
import '../../utils/routes/routes.dart';

class SignupController extends GetxController with GetTickerProviderStateMixin {
  final state = SignupState();
  late TabController tabController = TabController(length: 3, vsync: this);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StorePrefrences stp = StorePrefrences();

  setLoading(value) {
    state.loading.value = value;
  }

  // user signUp Functions {
  void registerUserWithEmailAndPassword(
      UserModel userinfo, String email, password) async {
    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userinfo.id = auth.currentUser!.uid.toString();
        StorePrefrences sp = StorePrefrences();
        sp.setIsFirstOpen(true);
        createUser(userinfo);
        Snackbar.showSnackBar('Success', 'Successfully create an account.',Icons.done_all);
        setLoading(false);
        clearControllers();

      }).onError((error, stackTrace) {
        setLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
    } catch (_) {
      setLoading(false);
    }
  }

  createUser(UserModel user) async {
    setLoading(true);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson())
        .whenComplete(() {
      print('Account created Successfully');

      setLoading(false);
      StorePrefrences sp = StorePrefrences();
      sp.setIsFirstOpen(true);
      Get.offAllNamed(AppPages.applicationView);
      print('success');
    }).catchError((error, stackTrace) {
      print("Error occurred");
      setLoading(false);
    });
  }

  void storeUser(
      UserModel user, BuildContext context, String email, String pass) async {
    registerUserWithEmailAndPassword(user, email, pass);
  }

  clearControllers() {
    state.signUpEmailController.clear();
    state.signUpPhoneController.clear();
    state.signUpUserController.clear();
    state.signUpPasswordController.clear();
  }

//   }

// user Login function
  void loginUserWithEmailAndPassword(String email, password) async {
    setLoading(true);
    try {
      var user = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final serviceData = await firestore
            .collection('serviceProviders')
            .where('id', isEqualTo: auth.currentUser!.uid.toString())
            .get();
        if (serviceData.docs.isNotEmpty) {
          StorePrefrences sp = StorePrefrences();
          sp.setIsFirstOpen(true);
          Get.offAllNamed(AppPages.providerHomeView);
          setLoading(false);
        } else {
          StorePrefrences sp = StorePrefrences();
          sp.setIsFirstOpen(true);
          Get.offAllNamed(AppPages.applicationView);
          setLoading(false);
        }

        setLoading(false);

        state.loginEmailController.clear();
        state.loginPasswordController.clear();
      }).onError((error, stackTrace) {
        setLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
    } catch (_) {
      setLoading(false);
    }
  }

//   serviceProvider signUp Functions

  void registerServiceProviderWithEmailAndPassword(
      ServiceProviderModel serviceProviderModel,
      String email,
      String password) async {
    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print("Information Received");
        // toastInfo(msg: "You'll receive confirmation \nmail shortly");

        // Get.to(() => SignUpMsg());

        StorePrefrences sp = StorePrefrences();
        sp.setIsFirstOpen(true);
        serviceProviderModel.id = auth.currentUser!.uid.toString();
        createServiceProvider(serviceProviderModel);
        clearProviderControllers();
        setLoading(false);
      }).onError((error, stackTrace) {
        state.loading.value = false;
        // toastInfo(msg: error.toString());
        print('error');
      });
    } on FirebaseAuthException catch (e) {
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      // toastInfo(msg: ex.toString());
      state.loading.value = false;
    } catch (_) {
      state.loading.value = false;
    }
  }

// this function is to store user in Firebase FireStore
  createServiceProvider(ServiceProviderModel serviceProviderModel) async {
    // state.loading.value = true;
    try {
      await firestore
          .collection('serviceProviders')
          .doc(auth.currentUser!.uid.toString())
          .set(serviceProviderModel.toJson())
          .then((value) {
            stp.setIsFirstOpen(true);
        // Get.to(() => CompanyApprovalPage());
        Get.offAllNamed(AppPages.providerHomeView);
        // auth.signOut();
        // Get.offAllNamed(AppRoutes.LOGIN_SIGN_UP);
        setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
        // toastInfo(msg: error.toString());
      });
    } catch (e) {
      // toastInfo(msg: e.toString());
      setLoading(false);
    }
  }

//  for registering and storing service provider
  void storeServiceProvider(ServiceProviderModel serviceProviderModel,
      BuildContext context, String email, pass) {
    registerServiceProviderWithEmailAndPassword(
        serviceProviderModel, email, pass);
  }

  clearProviderControllers() {
    state.serviceProviderPassController.clear();
    state.serviceProviderPhoneNumberController.clear();
    state.serviceProviderNameController.clear();
    state.serviceProviderEmailController.clear();
  }
}
