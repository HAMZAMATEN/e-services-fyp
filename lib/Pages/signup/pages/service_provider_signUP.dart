import 'package:e_services_fyp/Pages/signup/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/utils/models/service_provide_model.dart';
import 'package:e_services_fyp/utils/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/widgets/custom_text_field.dart';
import '../../../utils/compnents/round_button.dart';

class ServiceProviderView extends GetView<SignupController> {
  const ServiceProviderView({super.key});

  Widget serviceList() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Service',
              style: GoogleFonts.poppins(fontSize: 17),
            ),
            DropdownButton(
                iconEnabledColor: AppColors.iconsColor,
                hint: Text(
                  controller.state.serviceOffering.value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Carpenter'),
                    value: 'carpenter',
                  ),
                  DropdownMenuItem(
                    child: Text('Smartphone'),
                    value: 'smartphone',
                  ),
                  DropdownMenuItem(
                    child: Text('Electrician'),
                    value: 'electrician',
                  ),
                  DropdownMenuItem(
                    child: Text('Plumber'),
                    value: 'plumber',
                  ),
                  DropdownMenuItem(
                    child: Text('AC-Repair'),
                    value: 'ac-repair',
                  ),
                  DropdownMenuItem(
                    child: Text('Cook'),
                    value: 'cook',
                  ),
                  DropdownMenuItem(
                    child: Text('Painter'),
                    value: 'painter',
                  ),
                  DropdownMenuItem(
                    child: Text('Laundry'),
                    value: 'laundry',
                  ),
                  DropdownMenuItem(
                    child: Text('Cleaning'),
                    value: 'cleaning',
                  ),
                  DropdownMenuItem(
                    child: Text('Saloon'),
                    value: 'saloon',
                  )
                ],
                onChanged: (value) {
                  controller.state.serviceOffering.value = value.toString();
                }),
          ],
        ),
      );
    });
  }

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
                  contr: controller.state.serviceProviderNameController,
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
                  contr: controller.state.serviceProviderEmailController,
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
                  contr: controller.state.serviceProviderPhoneNumberController,
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
                  contr: controller.state.serviceProviderPassController,
                  descrip: 'Password',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  obsecure: true,
                  icon: Icons.lock_outline,
                ),
                SizedBox(
                  height: 5,
                ),
                serviceList(),
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
                            if (controller.state.serviceProviderNameController.text.isNotEmpty &&
                                controller.state.serviceProviderEmailController
                                    .text.isNotEmpty &&
                                controller
                                    .state
                                    .serviceProviderPhoneNumberController
                                    .text
                                    .isNotEmpty &&
                                controller.state.serviceProviderPassController
                                    .text.isNotEmpty &&
                                controller.state.serviceOffering.value !=
                                    'Select') {
                              print('object');
                              ServiceProviderModel spm = ServiceProviderModel(
                                  providerName: controller
                                      .state.serviceProviderNameController.text
                                      .trim(),
                                  phone: controller.state
                                      .serviceProviderPhoneNumberController.text
                                      .trim(),
                                  email: controller
                                      .state.serviceProviderEmailController.text
                                      .trim(),
                                  service:
                                      controller.state.serviceOffering.value);
                              controller.storeServiceProvider(
                                spm,
                                context,
                                controller
                                    .state.serviceProviderEmailController.text
                                    .trim(),
                                controller
                                    .state.serviceProviderPassController.text
                                    .trim(),
                              );
                            } else {
                              print('Error');
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
