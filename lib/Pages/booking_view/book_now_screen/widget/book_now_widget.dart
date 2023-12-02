import 'package:e_services_fyp/Pages/booking_view/controller.dart';
import 'package:e_services_fyp/Pages/scheduled_view/controller.dart';
import 'package:e_services_fyp/res/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
import '../../../../res/text_widget.dart';

class BookNowWidget extends GetView<BookingController> {
  String id;

  BookNowWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getCurrentServiceData(id);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomTextField(
            contr: TextEditingController(text: controller.state.name),
            descrip: 'Name',
            label: TextWidget(title: 'UserName'.toString(),textColor: Colors.black,),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            icon: Icons.person),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
            contr: TextEditingController(text: controller.state.phone),
            descrip: 'Phone No',
            label: TextWidget(title: 'User Phone'.toString(),textColor: Colors.black,),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            obsecure: false,
            icon: Icons.phone),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
            contr: controller.state.addressCon,
            descrip: 'Address',
            label: TextWidget(title: 'Address'.toString(),textColor: Colors.black,),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            icon: Icons.house_outlined),
        SizedBox(
          height: 10,
        ),
    Obx(() =>CustomTextField(
            contr: TextEditingController(text: controller.state.price.value),
            descrip: 'Hourly Rate',
            label: TextWidget(title: 'Hourly Rate'.toString(),textColor: Colors.black,),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            obsecure: false,
            readOnly: true,
            icon: Icons.price_check_outlined),),
        SizedBox(
          height: 10,
        ),
        Obx(() =>CustomTextField(
            contr: TextEditingController(text: controller.state.providerName.value),
            descrip: 'Provider Name',
            label: TextWidget(title: 'Provider Name'.toString(),textColor: Colors.black,),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            readOnly: true,
            icon: Icons.person_2_outlined),),
        SizedBox(
          height: 10,
        ),
        Obx(() =>CustomTextField(
            contr: TextEditingController(text: controller.state.providerPhone.value),
            descrip: 'Provider Phone',
            label: TextWidget(title: 'Provider Phone'.toString(),textColor: Colors.black,),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            obsecure: false,
            readOnly: true,
            icon: Icons.phone_android),),
        SizedBox(
          height: 10,
        ),
        Obx(() =>CustomTextField(
            contr: TextEditingController(text: controller.state.description.value),
            descrip: 'Description',
            label: TextWidget(title: 'Description'.toString(),textColor: Colors.black,),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            readOnly: true,
            icon: Icons.description_outlined)),
        SizedBox(
          height: 10,
        ),
        Obx(() =>CustomTextField(
            contr: TextEditingController(text: controller.state.service.value),
            descrip: 'Service Name',
            label: TextWidget(title: 'Service Name'.toString(),textColor: Colors.black,),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            readOnly: true,
            icon: Icons.design_services_outlined),),
      ]),
    );
  }
}
