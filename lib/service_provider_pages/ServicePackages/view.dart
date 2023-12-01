import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/widgets/container_card.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/AddPackage/view.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/controller.dart';
import 'package:e_services_fyp/utils/routes/routes.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicePackagesView extends GetView<ServicePackagesController> {
  const ServicePackagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  // Get.to(()=>AddPackageView());
                Get.toNamed(AppPages.addPackageView);
                },
                child: ContainerCard(
                  title: 'Add Offer',
                  icon: Icons.add_business,
                  color: AppColors.iconsColor,
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: (){
                  Get.toNamed(AppPages.managePackageView);
                },
                child: ContainerCard(
                  title: 'Manage Offers',
                  icon: Icons.edit_calendar,
                  color: AppColors.iconsColor,
                ),
              ),
              // SizedBox(height: 16.0), // Add some space between the containers
              // ContainerCard(
              //   title: 'Direct Orders',
              //   icon: Icons.shopping_cart,
              //   color: AppColors.iconsColor,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
