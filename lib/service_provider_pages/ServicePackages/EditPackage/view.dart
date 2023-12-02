import 'dart:io';

import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:e_services_fyp/res/widgets/custom_text_field.dart';
import 'package:e_services_fyp/service_provider_pages/ServicePackages/EditPackage/controller.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/compnents/snackbar_widget.dart';
import 'package:e_services_fyp/utils/models/service_package_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPackageView extends GetView<EditPackageController> {
  String packageId;

  EditPackageView({Key? key, required this.packageId}) : super(key: key);
  final controller = Get.put<EditPackageController>(EditPackageController());

  @override
  Widget build(BuildContext context) {
    controller.fetchDetails(packageId);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0, top: 20),
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back)),
                  ],
                ),
              ),
            ),
            Obx(() {
              return controller.state.infoLoading == true
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: AppColors.iconsColor,
                        ),
                      ],
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: Column(
                        children: [
                          GetBuilder<EditPackageController>(
                              builder: (AddPackageController) {
                            return InkWell(
                              onTap: () {
                                controller.showImage(context);
                              },
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(140)),
                                child: controller.image == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          controller.state.serviceImage
                                              .toString(),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(controller.image!.path).absolute,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                              ),
                            );
                          }),
                          InkWell(
                              onTap: () {
                                controller.showImage(context);
                              },
                              child: TextWidget(
                                title: 'Tap to Select',
                                textColor: Colors.black,
                              )),
                          SizedBox(height: 12),
                          CustomTextField(
                              contr: controller.state.providerNameController,
                              descrip: 'Name',
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              obsecure: false,
                              icon: Icons.person),
                          SizedBox(height: 12),
                          CustomTextField(
                              contr: controller.state.providerEmailController,
                              descrip: 'Email',
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              obsecure: false,
                              icon: Icons.email),
                          SizedBox(height: 12),
                          CustomTextField(
                              contr: controller.state.providerPhoneController,
                              descrip: 'Number',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              obsecure: false,
                              icon: Icons.phone),
                          SizedBox(height: 12),
                          CustomTextField(
                              contr: controller.state.serviceController,
                              descrip: 'Service',
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              obsecure: false,
                              icon: Icons.home_repair_service),
                          SizedBox(height: 12),
                          CustomTextField(
                            contr: controller.state.hourlyRateController,
                            descrip: 'Hourly Rate in Rs',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            obsecure: false,
                            icon: Icons.price_change_outlined,
                          ),
                          SizedBox(height: 12),
                          CustomTextField(
                              contr: controller.state.descriptionController,
                              descrip: "Description",
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.multiline,
                              obsecure: false,
                              icon: Icons.description),
                          SizedBox(height: 24),
                          Obx(() {
                            return controller.state.buttonLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.iconsColor,
                                    ),
                                  )
                                : RoundButton(
                                    title: 'Add Offer',
                                    onPress: () {
                                      if (controller.state.hourlyRateController.text == "" ||
                                          controller.state.hourlyRateController
                                                  .text ==
                                              "" ||
                                          controller.state.serviceImage == "") {
                                        Snackbar.showSnackBar(
                                            "Error",
                                            "Enter all fields",
                                            Icons.error_outline);
                                      } else {
                                        ServicePackageModel package =
                                            ServicePackageModel(
                                          providerName: controller
                                              .state.providerNameController.text
                                              .toString(),
                                          providerPhone: controller.state
                                              .providerPhoneController.text
                                              .toString(),
                                          providerEmail: controller.state
                                              .providerEmailController.text
                                              .toString(),
                                          providerId: SessionController()
                                              .userId
                                              .toString(),
                                          providerImageUrl: controller.state
                                              .providerImageController.text
                                              .toString(),
                                          hourlyRate: controller
                                              .state.hourlyRateController.text
                                              .trim()
                                              .toString(),
                                          service: controller
                                              .state.serviceController.text
                                              .trim()
                                              .toString(),
                                          description: controller
                                              .state.descriptionController.text
                                              .trim()
                                              .toString(),
                                          id: controller.state.packageId
                                              .toString(),
                                          stars: [],
                                        );
                                        controller.uploadServiceData(
                                            context, package);
                                      }
                                    },
                                  );
                          }),
                        ],
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
