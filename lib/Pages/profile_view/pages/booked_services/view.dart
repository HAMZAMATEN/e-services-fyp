import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/booked_services/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/booked_services/widgets/booked_services.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/scheduled_services_view/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/text_widget.dart';

class BookedServicesScreen extends GetView<BookedServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextWidget(
          title: 'Booked Services'
              '',
          fontSize: 18,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: controller.firestore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    print(
                        'length is: ' + snapshot.data!.docs.length.toString());
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: BookedServiceContainer(
                        serviceName: snapshot.data!.docs[index]['serviceName']
                            .toString(),
                        serviceLable: snapshot.data!.docs[index]['description']
                            .toString(),
                        imageUrl:
                            snapshot.data!.docs[index]['imageUrl'].toString(),
                        price: double.parse(
                            snapshot.data!.docs[index]['hourlyRate']),
                        id: snapshot.data!.docs[index]['id'].toString(),
                        serviceProviderName: snapshot.data!.docs[index]
                            ['providerName'],
                        serviceProviderImage: snapshot.data!.docs[index]
                            ['providerImgUrl'],
                        pid: snapshot.data!.docs[index]['pId'], phone: snapshot.data!.docs[index]
                      ['providerPhone'],
                        status: snapshot.data!.docs[index]['status'].toString(),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.iconsColor,
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.iconsColor,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
