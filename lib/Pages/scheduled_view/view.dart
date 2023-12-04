import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_services_fyp/Pages/home/controller.dart';
import 'package:e_services_fyp/Pages/scheduled_view/controller.dart';
import 'package:e_services_fyp/Pages/scheduled_view/widgets/map_screen.dart';
import 'package:e_services_fyp/Pages/scheduled_view/widgets/scheduled_widget.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:e_services_fyp/utils/compnents/round_button.dart';
import 'package:e_services_fyp/utils/models/scheduled_Service_model.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../res/colors.dart';
import '../../res/text_widget.dart';
import '../../utils/compnents/snackbar_widget.dart';

class ScheduledView extends GetView<ScheduledController> {
  const ScheduledView({Key? key}) : super(key: key);

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
    Get.lazyPut<ScheduledController>(() => ScheduledController());
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Scheduled',
          fontSize: 20,
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PersonData(),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: serviceList(),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(LocationSelectionScreen());
                },
                child: Obx(() => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 70,
                        width: 400,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.iconsColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.map_outlined,
                              color: AppColors.textFieldBgColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.state.selectedLatLng.value ==
                                        LatLng(32.082466, 72.669128)
                                    ? "Select Location on Map"
                                    : controller.state.selectedAddress.value
                                        .toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Obx(() => controller.state.loading.value == true
                  ? CircularProgressIndicator(
                      color: AppColors.iconsColor,
                    )
                  : RoundButton(
                      title: "Confirm ",
                      onPress: () {
                        if (controller.state.nameCon.text.isEmpty ||
                            controller.state.phoneCon.text.isEmpty ||
                            controller.state.addCon.text.isEmpty ||
                            controller.state.serviceNameCon.text.isEmpty ||
                            controller.state.serviceOffering.value == 'Select' ||
                            controller.state.selectedLatLng.value ==
                                LatLng(32.082466, 72.669128) ||
                            controller.state.selectedAddress.value.isEmpty) {
                          Snackbar.showSnackBar('Error',
                              'All fields must be filled', Icons.error_outline);
                        } else {
                          print("Date in milliseconds : " +
                              controller.state.selectedDate.value
                                  .millisecondsSinceEpoch
                                  .toString());
                          DateTime parseTime = DateFormat("hh:mm a").parse(
                              controller.state.selectedTime.value.toString());
                          int formattedTime = parseTime.millisecondsSinceEpoch;

                          print("Time in milliseconds : " +
                              formattedTime.toString());
                          int formattedDate = controller
                              .state.selectedDate.value.millisecondsSinceEpoch;
                          ScheduledServiceModel scm = ScheduledServiceModel(
                            serviceName:
                                controller.state.serviceNameCon.text.trim(),
                            phone: controller.state.phoneCon.text.trim(),
                            address: controller.state.addCon.text.trim(),
                            name: controller.state.nameCon.text.trim(),
                            date: formattedDate.toString(),
                            time: formattedTime.toString(),
                            service: controller.state.serviceOffering.value
                                .toString(),
                            lat: controller.state.selectedLatLng.value.latitude,
                            lang:
                                controller.state.selectedLatLng.value.longitude,
                          );
                          controller.storeDataInFirebase(scm);
                        }
                      }
                      // Get.toNamed(AppRoutes.SuccessfulView),

                      )),
            ],
          ),
        ),
      ),
    );
  }
}
