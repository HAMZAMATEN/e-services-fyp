import 'package:e_services_fyp/Pages/signup/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../res/widgets/custom_text_field.dart';
import '../../../utils/compnents/round_button.dart';

class LoginPage extends GetView<SignupController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CustomTextField(
                  contr: controller.state.loginEmailController,
                  descrip: 'Email',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  obsecure: false,
                  icon: Icons.email_outlined,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  contr: controller.state.loginPasswordController,
                  descrip: 'Password',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  obsecure: true,
                  icon: Icons.lock_outline,
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(
                  () => controller.state.loading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.iconsColor,
                          ),
                        )
                      : RoundButton(
                          title: 'Login',
                          onPress: () {
                            controller.loginUserWithEmailAndPassword(
                              controller.state.loginEmailController.text.trim(),
                              controller.state.loginPasswordController.text
                                  .trim(),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
