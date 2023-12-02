import 'package:e_services_fyp/Pages/booking_view/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BookingContainer extends GetView<BookingController> {
  final String serviceName;
  final String serviceLable;
  final String imageUrl;
  final double price;
  var feedbackStars;
  final String serviceProviderName;
  final String serviceProviderImage;
  String? id;

  BookingContainer({
    required this.serviceName,
    required this.serviceLable,
    required this.imageUrl,
    required this.price,
    required this.feedbackStars,
    required this.serviceProviderName,
    required this.serviceProviderImage,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final con = Get.lazyPut<BookingController>(() => BookingController());
    return GestureDetector(
      onTap: () {
        // Get.toNamed(AppRoutes.BookingView);
      },
      child: Container(
        width: 320,
        height: 330,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                serviceName.capitalizeFirst.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              TextWidget(
                title: serviceLable,
                fontSize: 15,
                textColor: Colors.black,
              ),
              SizedBox(height: 5),
              imageUrl == ''
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
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                RatingBar.builder(
                  itemSize: 25,
                  initialRating: feedbackStars == [] ? 3 : feedbackStars,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
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
                ),
                // Text(
                //   '$feedbackStars Stars',
                //   style: TextStyle(
                //     fontSize: 18,
                //   ),
                // ),
                Spacer(),
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ]),
              SizedBox(height: 10),
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
                            backgroundImage: NetworkImage(serviceProviderImage),
                            radius: 20,
                          ),
                        ),
                  SizedBox(width: 10),
                  Text(serviceProviderName),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
