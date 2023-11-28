import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/service_provider_pages/offer_detail_screen/view.dart';
import 'package:e_services_fyp/service_provider_pages/shedule_offers/controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class ScheduleOffersView extends GetView<ScheduleOffersController> {
  ScheduleOffersView({Key? key}) : super(key: key);

  Widget _buildCard(AsyncSnapshot<QuerySnapshot> snapshot, index) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                blurRadius: 1
            ),
            BoxShadow(
              color: Colors.black,
              blurRadius: 2
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.white24,
            width: 0.01,
          )
        ),
        child: ListTile(
          onTap: () {
            Get.to(() => OfferDetailScreen(
                  id: snapshot.data!.docs[index]['id'].toString(),
                ));
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0, top: 10),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.grey[200]!),

              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_repair_service,
                  size: 40,
                  color: AppColors.iconsColor,
                ),
              ],
            ),
          ),
          title: Text(
            snapshot.data!.docs[index]['name'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    snapshot.data!.docs[index]['service'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.0),
                  Text("("),
                  Text(
                    snapshot.data!.docs[index]['serviceName'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(")"),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    'Time : ',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    controller.convertTime(snapshot.data!.docs[index]['time']),
                    // controller.convertMillisecondsToHrsMM(
                    //     snapshot.data!.docs[index]['time']),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    'Date : ',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    controller.convertMillisecondsToDateFormat(
                        snapshot.data!.docs[index]['date']),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Text(
                "Status:" + snapshot.data!.docs[index]['status'].toString(),
                style: TextStyle(fontSize: 14, color: AppColors.iconsColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.ref,
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
              return Center(
                child: Text('Error while Fetching Information'),
              );
            }
            if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Text('No Scheduled Services'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  double lat = snapshot.data!.docs[index]['lat'];
                  double long = snapshot.data!.docs[index]['lat'];
                  return _buildCard(snapshot, index);
                });
          },
        ),
      ),
    );
  }
}
