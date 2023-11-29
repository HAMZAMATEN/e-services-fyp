import 'dart:io';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/AddPackage/state.dart';
import 'package:e_services_fyp/utils/models/service_package_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/models/user_model.dart';

class AddPackageController extends GetxController {
  final state = AddPackageState();
  final userId = SessionController().userId.toString();
  final userRef = FirebaseFirestore.instance.collection('serviceProviders');
  final allServiceRef = FirebaseFirestore.instance.collection('allServices');
  final auth = FirebaseAuth.instance;

  Future<void> fetchDetails() async {
    state.infoLoading.value = true;
    DocumentSnapshot userInfo = await userRef.doc(userId).get();

    if (userInfo.exists) {
      state.providerNameController.text =
          userInfo['providerName'].toString().trim();
      state.providerPhoneController.text = userInfo['phone'].toString().trim();
      state.providerEmailController.text = userInfo['email'].toString().trim();
      state.serviceController.text = userInfo['service'].toString().trim();
      state.infoLoading.value = false;
    }
  }

 Future<void> uploadTourData (BuildContext context, ServicePackageModel model) async {
    try{
      // await allServiceRef.add();
    }catch(e){

    }
 }



  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;

  XFile? get image => _image;

  Future pickedImageFromGallery(
      BuildContext context, ServicePackageModel packageModel) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, packageModel);
      update();
    }
  }

  //
  Future pickedImageFromCamera(
      BuildContext context, ServicePackageModel packageModel) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, packageModel);
      update();
    }
  }

  void showImage(context, userModel) {
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
                    pickedImageFromCamera(context, userModel);
                    print('insideqw21');

                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickedImageFromGallery(context, userModel);
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

  Future uploadImage(BuildContext context, ServicePackageModel packageModel) async {
    // setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/serviceImage' + DateTime.now().toString());
    firebase_storage.UploadTask uploadTask =
    storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    state.serviceImage = await storageRef.getDownloadURL();

    FirebaseFirestore.instance
        .collection('allServices')
        .doc(auth.currentUser!.uid.toString())
        .update({
      'imageUrl': state.serviceImage.toString(),
    }).then((value) {
      // setLoading(false);
      Get.snackbar('Congrats', 'Update successfully');
      _image = null;
    }).onError((error, stackTrace) {
      // setLoading(false);
      Get.snackbar('Error is', error.toString());
    });
  }



}
