import 'package:e_services_fyp/Pages/scheduled_view/view.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/service_provider_pages/Orders/Screens/scheduled/view.dart';
import 'package:e_services_fyp/service_provider_pages/Orders/controller.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/widgets/container_card.dart';

class OrdersView extends GetView<OrdersControllers> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ContainerCard(
              //   title: 'All Orders',
              //   icon: Icons.all_inclusive_sharp,
              //   color: AppColors.iconsColor,
              // ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: (){
                  Get.to(()=>ScheduledOrdersView());
                },
                child: ContainerCard(
                  title: 'Scheduled Orders',
                  icon: Icons.schedule,
                  color: AppColors.iconsColor,
                ),
              ),
              SizedBox(height: 16.0), // Add some space between the containers
              InkWell(
                onTap: (){
                  Get.toNamed(AppPages.directOrdersView);
                },
                child: ContainerCard(
                  title: 'Direct Orders',
                  icon: Icons.shopping_cart,
                  color: AppColors.iconsColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
