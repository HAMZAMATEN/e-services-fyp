import 'package:e_services_fyp/Pages/signup/controller.dart';
import 'package:e_services_fyp/Pages/signup/pages/customer_sign_up.dart';
import 'package:e_services_fyp/Pages/signup/pages/login.dart';
import 'package:e_services_fyp/Pages/signup/pages/service_provider_signUP.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/widgets/custom_text_field.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/signUp.png',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                labelColor: AppColors.iconsColor,
                indicatorColor: AppColors.iconsColor,
                unselectedLabelColor: Colors.grey,
                tabAlignment: TabAlignment.center,
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                ),
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                ),

                tabs: [

                  Tab(
                    text: 'Login',
                  ),
                  Tab(
                    text: 'Customer\n   SignUp',

                  ),
                  Tab(
                    text: 'Service Provider\n         SignUp',
                  )
                ],
                controller: controller.tabController,
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
              margin: EdgeInsets.only(top: 10),
              // height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  LoginPage(),
                  CustomerSignUp(),
                  ServiceProviderView(),
                ],
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
