import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/booking_view/controller.dart';
import 'package:e_services_fyp/Pages/booking_view/widgets/booking_widget.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/widgets/services_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/text_widget.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<BookingController>(() => BookingController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.iconsColor,
        title: TextWidget(
          title: 'Booking',
          fontSize: 20,
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.firestore,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    controller.getAverageRating(snapshot.data!.docs[index]['id'].toString());

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Obx(() => BookingContainer(
                            serviceName: snapshot.data!.docs[index]['service']
                                .toString(),
                            serviceLable: snapshot
                                .data!.docs[index]['description']
                                .toString(),
                            imageUrl: snapshot.data!.docs[index]['imageUrl']
                                .toString(),
                            price: double.parse(
                                snapshot.data!.docs[index]['hourlyRate']),
                            feedbackStars:
                              controller.state.averageRating.value,

                            id: snapshot.data!.docs[index]['id'].toString(),
                            serviceProviderName: snapshot.data!.docs[index]
                                ['providerName'],
                            serviceProviderImage: snapshot.data!.docs[index]
                                ['providerImageUrl'],
                          )),
                    );
                  });
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
    );
  }
}
