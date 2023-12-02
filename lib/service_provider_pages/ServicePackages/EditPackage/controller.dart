import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/EditPackage/state.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:e_services_fyp/utils/models/service_package_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditPackageController extends GetxController {
final state = EditPackageState();


// final state = AddPackageState();
// final userId = SessionController().userId.toString();
final userRef = FirebaseFirestore.instance.collection('serviceProviders');
final allServiceRef = FirebaseFirestore.instance.collection('allServices');
final auth = FirebaseAuth.instance;

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;

  XFile? get image => _image;

Future<void> fetchDetails(String packageId) async {
  state.packageId = packageId;
  print(packageId);
  state.infoLoading.value = true;
  DocumentSnapshot userInfo = await allServiceRef.doc(state.packageId).get();
  DocumentSnapshot providerInfo = await userRef.doc(SessionController().userId.toString()).get();

  if (userInfo.exists) {
    state.providerNameController.text =  userInfo['providerName'].toString().trim();
    state.providerPhoneController.text = userInfo['providerPhone'].toString().trim();
    state.providerEmailController.text = userInfo['providerEmail'].toString().trim();
    state.serviceController.text = userInfo['service'].toString().trim();
    state.hourlyRateController.text = userInfo['hourlyRate'].toString().trim();
    state.descriptionController.text = userInfo['description'].toString().trim();
    state.serviceImage.value = userInfo['imageUrl'].toString().trim();

    state.providerImageController.text = providerInfo['photoUrl'].toString().trim();

    _image = null;
    state.infoLoading.value = false;
  }
}

void setLoading(bool val){
  state.buttonLoading.value = val;
}

Future<void> uploadServiceData (BuildContext context, ServicePackageModel model) async {
  setLoading(true);
  String timeStamp = DateTime.timestamp().microsecondsSinceEpoch.toString();
  try{
    await allServiceRef.doc(state.packageId).update(
        // 'imageUrl' : state.serviceImage,
        model.toJson(),
    ).then((value){

      image != null ? (uploadImage(context, timeStamp)) : (FirebaseFirestore.instance
          .collection('allServices')
          .doc(state.packageId)
          .update({
        'imageUrl': state.serviceImage.value.toString(),
      }).then((value) {
        setLoading(false);
        // _image = null;
        Snackbar.showSnackBar("Congratulation", "Added Successfully", Icons.error_outline);
        setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
        ;
        Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
      }));
    }).onError((error, stackTrace){
      Snackbar.showSnackBar("Error", error.toString(), Icons.error);
      setLoading(false);
    });
  }catch(e){
    Snackbar.showSnackBar("Error", e.toString(), Icons.error);
    setLoading(false);
  }
}





Future pickedImageFromGallery(
    BuildContext context) async {
  final pickedImage =
  await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

  if (pickedImage != null) {
    _image = XFile(pickedImage.path);
    state.serviceImage.value = pickedImage.path.toString();

    update();
  }
}

//
Future pickedImageFromCamera(
    BuildContext context) async {
  final pickedImage =
  await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

  if (pickedImage != null) {
    _image = XFile(pickedImage.path);
    state.serviceImage.value = pickedImage.path.toString();
    update();
  }
}

void showImage(context) {
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
                  // pickedImageFromCamera(context, userModel);
                  pickedImageFromCamera(context);
                  print('insideqw21');

                  Navigator.pop(context);
                },
                leading: Icon(Icons.camera),
                title: Text('Camera'),
              ),
              ListTile(
                onTap: () {
                  pickedImageFromGallery(context);
                  // pickedImageFromGallery(context, userModel);
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

Future uploadImage(BuildContext context, String timeStamp) async {
  try{
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/serviceImage' + timeStamp);
    firebase_storage.UploadTask uploadTask =
    storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    String imageUrl = await storageRef.getDownloadURL();


    FirebaseFirestore.instance
        .collection('allServices')
        .doc(state.packageId)
        .update({
      'imageUrl': imageUrl,
    }).then((value) {
      setLoading(false);
      // _image = null;
      Snackbar.showSnackBar("Congratulation", "Added Successfully", Icons.error_outline);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      ;
      Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
    });
  }catch(e){
    setLoading(false);
    Snackbar.showSnackBar("Error", e.toString(), Icons.error_outline);
  }
}
}