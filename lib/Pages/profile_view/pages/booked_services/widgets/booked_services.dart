import 'package:e_services_fyp/Pages/booking_view/book_now_screen/book_now_screen.dart';
import 'package:e_services_fyp/Pages/booking_view/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/booked_services/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BookedServiceContainer extends GetView<BookedServicesController> {
  final String serviceName;
  final String serviceLable;
  final String imageUrl;
  final double price;
  final String phone;
  final String serviceProviderName;
  final String serviceProviderImage;
  String? id;
  String pid;
  String status;

  BookedServiceContainer({
    required this.serviceName,
    required this.serviceLable,
    required this.imageUrl,
    required this.price,
    required this.serviceProviderName,
    required this.serviceProviderImage,
    required this.phone,
    this.id,
    required this.pid,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final con = Get.lazyPut<BookingController>(() => BookingController());
    return GestureDetector(
      onTap: () {
        // Get.toNamed(AppRoutes.BookingView);
      },
      child: Container(
        width: 360,
        height: 350,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextWidget(
                title: serviceName.capitalizeFirst.toString(),
                textColor: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              Flexible(
                child: TextWidget(
                  title: serviceLable.capitalizeFirst.toString(),
                  fontSize: 15,
                  textColor: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              imageUrl == ''
                  ? Icon(
                Icons.image,
                color: AppColors.iconsColor,
              )
                  : Container(
                    child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
                  ),
              SizedBox(height: 10),
              Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  TextWidget(
                    title: "Phone# : " + phone,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                  ),
                  Spacer(),
                  TextWidget(
                    title: '\$$price',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        serviceProviderImage == ''
                            ? Icon(
                          Icons.person_2_outlined,
                          color: AppColors.iconsColor,
                        )
                            : GestureDetector(
                          onTap: () {
                            // Get.toNamed(AppRoutes.P_ProfileView);
                          },
                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage(serviceProviderImage),
                            radius: 20,
                          ),
                        ),
                        SizedBox(width: 10),
                        TextWidget(
                          title: serviceProviderName.capitalizeFirst.toString(),
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                    Container(
                      // height: 20,
                      // width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.iconsColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                      Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 6),
                          child: TextWidget(
                            title: status.toString(),
                            fontSize: 18,
                            textColor: status == 'Pending'? Colors.yellow : status == 'Confirmed' ? Colors.green : Colors.red,
                          ),
                        ),
                      ),

                    ),

                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
