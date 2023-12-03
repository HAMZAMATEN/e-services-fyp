import 'package:e_services_fyp/Pages/catogery_view/widget/categoryWidget.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryItem extends StatelessWidget {
  final String imageName;
  final String categoryName;
  final String catVal;


  const CategoryItem({Key? key,
    required this.imageName,
    required this.categoryName,
    required this.catVal,

  }): super(key : key );


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CategoryWidget(catValue: catVal));
      },
      child: Container(
        width: 90,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.grey.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/$imageName.png", height: 80),
            SizedBox(height: 5),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

      ),
    );

  }
}