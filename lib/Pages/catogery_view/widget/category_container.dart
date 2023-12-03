import 'package:e_services_fyp/Pages/booking_view/book_now_screen/book_now_screen.dart';
import 'package:e_services_fyp/Pages/booking_view/controller.dart';
import 'package:e_services_fyp/Pages/catogery_view/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CategoryContainer extends GetView<CatogeryController> {
  final String serviceName;
  final String serviceLable;
  final String imageUrl;
  final double price;
  var feedbackStars;
  final String serviceProviderName;
  final String serviceProviderImage;
  String? id;
  String pid;
  // bool isBooked;

  CategoryContainer({
    required this.serviceName,
    required this.serviceLable,
    required this.imageUrl,
    required this.price,
    required this.feedbackStars,
    required this.serviceProviderName,
    required this.serviceProviderImage,
    this.id,
    required this.pid,
    // required this.isBooked,
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
        height: 330,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
              Container(
                child: imageUrl == ''
                    ? Icon(
                  Icons.image,
                  color: AppColors.iconsColor,
                )
                    : Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Obx(() => RatingBar.builder(
                  itemSize: 25,
                  initialRating: controller.state.averageRating.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  glow: true,
                  glowRadius: 5,
                  glowColor: Colors.amberAccent,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                    controller.addRating(
                      rating,
                      id.toString(),
                    );
                  },
                )),
                Spacer(),
                TextWidget(
                  title: '\$$price',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                ),
              ]),
              SizedBox(height: 10),
              Row(
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
                    // height: 45,
                    // width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.iconsColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(BookNowView(id: id.toString(),pid: pid,));
                        print('id is:'+id.toString());
                      },
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextWidget(
                            title: 'Book Now',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
