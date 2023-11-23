import 'package:e_services_fyp/Pages/signup/controller.dart';
import 'package:e_services_fyp/res/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                labelColor: Colors.cyan,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Customer',
                  ),
                  Tab(
                    text: 'Service Provider',
                  )
                ],
                controller: controller.tabController,
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
              margin: EdgeInsets.only(top: 30),
              // height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(
                      children: [
                        CustomTextField(
                            contr: TextEditingController(),
                            descrip: 'Name',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            obsecure: false,
                            icon: Icons.person,
                        ),
                      ],
                    )
                  ),
                  Scaffold(
                    body: Text('2'),),
                ],
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
