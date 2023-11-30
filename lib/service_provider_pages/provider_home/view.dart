import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:e_services_fyp/service_provider_pages/Orders/view.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/view.dart';
import 'package:e_services_fyp/service_provider_pages/drawer/view.dart';
import 'package:e_services_fyp/service_provider_pages/provider_home/controller.dart';
import 'package:e_services_fyp/service_provider_pages/shedule_offers/view.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SPHomeView extends GetView<SPHomeController> {
  SPHomeView({Key? key}) : super(key: key);


  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: BuildDrawer.buildDrawer(context),
        key: _scaffoldKey,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: (){
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Icon(Icons.menu , color: Colors.white,),
                ),
                title: TextWidget(
                  title: 'Administration',
                  textColor: AppColors.textFieldBgColor,
                  fontSize: 25,
                ),
                actions: [
                  Obx((){
                    return IconButton(
                      onPressed: () {
                        controller.handleLogout();
                        // Get.offAllNamed(AppRoutes.logInScreen);
                      },
                      icon: controller.state.logoutLoading.value ? Container(child: Center(child: CircularProgressIndicator(color: Colors.white,))): Icon(
                        Icons.logout_outlined,
                        color: AppColors.textFieldBgColor,
                      ),
                    );
                  },),
                ],
                backgroundColor: AppColors.iconsColor.withOpacity(0.9),
                pinned: true, // to ensure the AppBar remains visible at the top
                floating: true, // to show/hide AppBar when scrolling up/down
                bottom: PreferredSize(
                  preferredSize:
                      Size.fromHeight(50.0), // Set this appropriately
                  child: TabBar(
                    labelColor: AppColors.textFieldBgColor,
                    unselectedLabelColor:
                        AppColors.textFieldBgColor.withOpacity(0.5),
                    indicatorColor: AppColors.textFieldBgColor,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                    tabs: [
                      Tab(text: 'Offerings'),
                      Tab(text: 'ORDERS'),
                      Tab(text: 'Packages'),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    ScheduleOffersView(),
                    OrdersView(),
                    ServicePackagesView(),
                    // DashBoardView(),
                    // OrderHomeView(),
                    // InventoryView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
