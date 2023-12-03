import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/catogery_view/widget/category_container.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class CategoryWidget extends GetView<CatogeryController> {
  String catValue;

  CategoryWidget({super.key, required this.catValue});

  @override
  Widget build(BuildContext context) {
    final con = Get.lazyPut<CatogeryController>(() => CatogeryController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.iconsColor,
        title: TextWidget(
          title: catValue.capitalizeFirst.toString(),
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
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('allServices')
              .where('service', isEqualTo: catValue)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              print('data');
              print('length:' + snapshot.data!.docs.length.toString());

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      controller.getAverageRating(snapshot.data!.docs[index]['id'].toString());
                  if(snapshot.data!.docs.length == 0) {
                    return Row(
                      children: [
                        Icon(Icons.add_shopping_cart_outlined),
                        Center(
                          child: TextWidget(
                            title: 'No services there yet',
                            textColor: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    );
                  }else {
                    return
                      Obx(() => CategoryContainer(
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
                      ['providerImageUrl'], pid: snapshot.data!.docs[index]
                    ['providerId'],
                      // isBooked: snapshot.data!.docs[index]
                      // ['isBooked'],
                    ),);
                  }
                }),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.iconsColor,
                ),
              );
            } else {
              return Container(
                color: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}
