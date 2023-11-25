import 'package:e_services_fyp/Pages/signup/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:e_services_fyp/utils/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/widgets/custom_text_field.dart';
import '../../../utils/compnents/round_button.dart';

class CustomerSignUp extends GetView<SignupController> {
  const CustomerSignUp({super.key});

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
                  contr: controller.state.signUpUserController,
                  descrip: 'Name',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  obsecure: false,
                  icon: Icons.person,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  contr: controller.state.signUpEmailController,
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
                  contr: controller.state.signUpPhoneController,
                  descrip: 'Phone',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  obsecure: false,
                  icon: Icons.phone,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  contr: controller.state.signUpPasswordController,
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
                          title: 'SignUp',
                          onPress: () {
                            if (controller.state.signUpUserController.text
                                    .isNotEmpty &&
                                controller.state.signUpEmailController.text
                                    .isNotEmpty &&
                                controller.state.signUpPhoneController.text
                                    .isNotEmpty &&
                                controller.state.signUpPasswordController.text
                                    .isNotEmpty) {
                              print('object');
                              UserModel user = UserModel(
                                userName: controller
                                    .state.signUpUserController.text
                                    .trim(),
                                phone: controller
                                    .state.signUpPhoneController.text
                                    .trim(),
                                email: controller
                                    .state.signUpEmailController.text
                                    .trim(), photoUrl: '',
                              );
                              controller.storeUser(
                                  user,
                                  context,
                                  controller.state.signUpEmailController.text
                                      .trim(),
                                  controller.state.signUpPasswordController.text
                                      .trim());
                            } else {
                              print('Error');
                              Snackbar.showSnackBar('Error', 'All fields must be filled',Icons.info_outline);
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
