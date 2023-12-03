import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/drawer/view.dart';
import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/home/widgets/home_widget.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:e_services_fyp/res/widgets/catogery_Items.dart';
import 'package:e_services_fyp/res/widgets/services_container.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/routes/routes.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final con = Get.lazyPut<HomeController>(() => HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: UserDrawer.buildDrawer(context),
      appBar: AppBar(
        title: Text(
          'E_Services',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white
              //AppColors.secondaryColor,
              ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.iconsColor,
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(
            Icons.menu,
            size: 30,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: 'HI,\n Need some help today?',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.textColor,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 4)),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //search box
                            Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor,
                              ),
                            ),

                            Icon(
                              Icons.mic,
                              size: 25,
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          title: 'Categories',

                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          //  color: AppColors.secondaryColor,
                          textColor: AppColors.textColor.withOpacity(0.5),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Get.toNamed(AppPages.catogeryView);
                          },
                          child: TextWidget(
                            title: 'ViewAll',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.textColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    //categories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CategoryItem(
                            imageName: 'plumber',
                            categoryName: 'Plumber',
                            catVal: 'plumber',
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          CategoryItem(
                            imageName: 'laundry',
                            categoryName: 'Laundry',
                            catVal: 'laundry',
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          CategoryItem(
                            imageName: 'repair',
                            categoryName: 'AC Repair',
                            catVal: 'ac-repair',
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          CategoryItem(
                            imageName: 'cleaning',
                            categoryName: 'Cleaning',
                            catVal: 'cleaning',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          title: 'Featured',

                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          //  color: AppColors.secondaryColor,
                          textColor: AppColors.textColor.withOpacity(0.5),
                        ),

                        OutlinedButton(
                          onPressed: () {
                            Get.toNamed(AppPages.bookingView);
                          },
                          child: TextWidget(
                            title: 'ViewAll',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.textColor.withOpacity(0.5),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 350,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: controller.firestore,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  String serviceId = snapshot.data!.docs[index]['id'].toString();
                                  controller.getAverageRating(serviceId);

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 00, horizontal: 0),
                                    child: HomeContainer(
                                          serviceName: snapshot
                                              .data!.docs[index]['service']
                                              .toString(),
                                          serviceLable: snapshot
                                              .data!.docs[index]['description']
                                              .toString(),
                                          imageUrl: snapshot
                                              .data!.docs[index]['imageUrl']
                                              .toString(),
                                          price: double.parse(snapshot
                                              .data!.docs[index]['hourlyRate']),
                                          feedbackStars: controller
                                              .serviceAverageRatings[serviceId]?.value ?? 0.0,
                                          id: snapshot.data!.docs[index]['id']
                                              .toString(),
                                          serviceProviderName: snapshot.data!
                                              .docs[index]['providerName'],
                                          serviceProviderImage: snapshot.data!
                                              .docs[index]['providerImageUrl'],
                                          // isBooked: snapshot.data!.docs[index]
                                          //     ['isBooked'],
                                        ),
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
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
