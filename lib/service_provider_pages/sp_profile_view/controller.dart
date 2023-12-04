import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/service_provider_pages/sp_profile_view/state.dart';
import 'package:e_services_fyp/utils/models/service_provide_model.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/compnents/snackbar_widget.dart';
import '../../utils/models/user_model.dart';

class SpProfileController extends GetxController {
  final state = SpProfileState();

  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    print('doc is :' + FirebaseAuth.instance.currentUser!.uid.toString(),);

    final sna = FirebaseFirestore.instance
        .collection('serviceProviders')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();

    print('snapshot is: ' + sna.length.toString());
    return FirebaseFirestore.instance
        .collection('serviceProviders')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();

  }

  setLoading(value) {
    state.loading.value = value;
  }

  // for update and drawer screen
  Future<ServiceProviderModel> spGetUserDataForUpdate(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('serviceProviders')
        .where('id', isEqualTo: id)
        .get();
    final serviceData = snapshot.docs.map((e) => ServiceProviderModel.fromJson(e)).single;
    return serviceData;
  }

  spGetUsersData() async {
    final id = auth.currentUser!.uid.toString();
    if (id != '') {
      return await spGetUserDataForUpdate(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;

  XFile? get image => _image;

  Future pickedImageFromGallery(
      BuildContext context, ServiceProviderModel serviceProviderModel) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, serviceProviderModel);
      update();
    }
  }

  //
  Future pickedImageFromCamera(
      BuildContext context, ServiceProviderModel serviceProviderModel) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, serviceProviderModel);
      update();
    }
  }

  void showImage(context, serviceProviderModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 130,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                ListTile(
                  onTap: () {
                    print('inside');
                    pickedImageFromCamera(context, serviceProviderModel);
                    print('insideqw21');

                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickedImageFromGallery(context, serviceProviderModel);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text('Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future uploadImage(BuildContext context, ServiceProviderModel serviceProviderModel) async {
    // setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/spProfileImage' + DateTime.now().toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    state.spUserProfileImage = await storageRef.getDownloadURL();

    FirebaseFirestore.instance
        .collection('serviceProviders')
        .doc(auth.currentUser!.uid.toString())
        .update({
      'photoUrl': state.spUserProfileImage.toString(),
    }).then((value) {
      // setLoading(false);
      Snackbar.showSnackBar('Update', 'Successfully Updated', Icons.done_all);
      _image = null;
      state.loading.value = false;
    }).onError((error, stackTrace) {
      // setLoading(false);
      Snackbar.showSnackBar('Error is', error.toString(),Icons.error_outline);
      state.loading.value = false;
    });
  }

  // for updating user
  updateUserData(ServiceProviderModel serviceProviderModel) async {
    try {
      print('id' + serviceProviderModel.id.toString());
      setLoading(true);
      await FirebaseFirestore.instance
          .collection('serviceProviders')
          .doc(serviceProviderModel.id)
          .update(
        serviceProviderModel.toJson(),
      )
          .then((value) {
        setLoading(false);
        Snackbar.showSnackBar('Update', 'Successfully Updated', Icons.done_all);
      });
    }catch(e) {
      print('error:'+e.toString(),);
      setLoading(false);

    }
  }

  updateUser(ServiceProviderModel serviceProviderModel) async {
    await updateUserData(serviceProviderModel);
  }


  void setLogoutLoading(bool val){
    state.logoutLoading.value = val;
  }


  Future<void> handleLogout() async{
    setLogoutLoading(true);
    try{
      await auth.signOut().then((value){
        SessionController().userId = null;
        setLogoutLoading(false);
        Get.offAllNamed(AppPages.signUpView);
        Snackbar.showSnackBar('Logout', 'Successfully', Icons.done_outline_rounded);
      }).onError((error, stackTrace){
        setLogoutLoading(false);
        Snackbar.showSnackBar('Error', error.toString(), Icons.error_outline);
      });
    }catch(e){
      setLogoutLoading(false);
      Snackbar.showSnackBar('Error', e.toString(), Icons.error_outline);
    }
  }
}
