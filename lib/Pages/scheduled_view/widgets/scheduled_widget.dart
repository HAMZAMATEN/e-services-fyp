import 'package:e_services_fyp/Pages/scheduled_view/controller.dart';
import 'package:e_services_fyp/res/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/colors.dart';

class PersonData extends GetView<ScheduledController> {
  PersonData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomTextField(
            contr: controller.state.nameCon,
            descrip: 'Name',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            icon: Icons.person),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
            contr: controller.state.phoneCon,
            descrip: 'Phone No',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            obsecure: false,
            icon: Icons.phone),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
            contr: controller.state.addCon,
            descrip: 'Address',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            icon: Icons.house_outlined),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
            contr: controller.state.serviceNameCon,
            descrip: 'Service Name',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            icon: Icons.design_services_outlined),

        SizedBox(
          height: 10,
        ),
        CustomTextField(
            contr: controller.state.timeCon,
            descrip: 'Time',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obsecure: false,
            icon: Icons.timer),

        // RoundButton(
        //   title: "Save",
        //   onPress: () => {},
        // ),
      ]),
    );
  }
}
