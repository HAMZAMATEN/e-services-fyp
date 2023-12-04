// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/EditPackage/view.dart';
// import 'package:e_services_fyp/res/widgets/service_provider_appBar.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/ManagePackages/controller.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/text_widget.dart';

class ManagePackagesView extends GetView<ManagePackageController> {
  const ManagePackagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Manage Services',
          fontSize: 20,
        ),
        backgroundColor: AppColors.iconsColor,
      ),

      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.serviceRef,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.iconsColor,
                ),
              );
            }
            if (snapshot.hasError) {
              Snackbar.showSnackBar('Error', snapshot.error.toString(),Icons.error_outline_outlined);
              return Container(
                child: Text("Snapshot error"),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No Services posted yet'),
              );
            }
            return Padding(
              padding:  EdgeInsets.only(bottom: 8,top:10, left: 5,right: 5),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ServiceCard(
                      imageUrl: snapshot.data!.docs[index]['imageUrl'].toString(),
                      hourlyRate: snapshot.data!.docs[index]['hourlyRate'].toString(),
                      description: snapshot.data!.docs[index]['description'].toString(),
                      serviceCatogery: snapshot.data!.docs[index]['service'].toString(),
                    packageId: snapshot.data!.docs[index]['id'].toString(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  // final Service service;
  final String imageUrl;
  final String hourlyRate;
  final String description;
  final String serviceCatogery;
  final String packageId;

  ServiceCard({required this.imageUrl, required this.hourlyRate, required this.description,required this.serviceCatogery,required this.packageId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
              topLeft: Radius.circular(10),

            ),
            child: Image.network(
              imageUrl,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hourly Rate: \$${hourlyRate.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment : MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Description: ${description}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    // Text(
                    //   'Description: ${description}',
                    //   style: TextStyle(color: Colors.grey),
                    // ),
                    InkWell(
                        onTap: (){
                          // Get.to(()=>EditPackageView(packageId: packageId));
                          // Get.toNamed(AppPages.editPackageView,arguments: {packageId});
                          Get.to(()=>EditPackageView(packageId: packageId));
                        },
                        child: Icon(Icons.change_circle_outlined,size: 30,color: Colors.black,)),
                  ],
                ),
                SizedBox(height: 5.0),
                Text(
                  'Category: ${serviceCatogery}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

