import 'package:e_services_fyp/Pages/catogery_view/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/widgets/catogery_Items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends GetView<CatogeryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.iconsColor,
          //  elevation: 0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                f
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Column(
                children: [
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'smartphone',
                  categoryName: 'Smartphone',
                  catVal: 'smartphone',
                ),
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'electrician',
                  categoryName: 'Electrician',
                  catVal: 'electrician',
                ),
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'plumber',
                  categoryName: 'Plumber',
                  catVal: 'plumber',

                ),
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'cleaning',
                  categoryName: 'Cleaning', catVal: 'cleaning',
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'repair',
                  categoryName: 'AC Repair', catVal: 'ac-repair',
                ),
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'chef',
                  categoryName: 'Cook', catVal: 'cook',
                ),
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'carpenter',
                  categoryName: 'Carpenter', catVal: 'carpenter',
                ),
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'salon',
                  categoryName: 'Salon', catVal: 'saloon',
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'painter',
                  categoryName: 'Painter', catVal: 'painter',
                ),
                SizedBox(
                  width: 10,
                ),
                CategoryItem(
                  imageName: 'laundry',
                  categoryName: 'Laundry', catVal: 'laundry',
                ),
              ]),
            ]),
          ),
        ));
  }
}
