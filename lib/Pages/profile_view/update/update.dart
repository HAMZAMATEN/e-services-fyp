import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/profile_view/controller.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:e_services_fyp/res/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../utils/compnents/round_button.dart';
import '../../../utils/models/user_model.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: TextWidget(
          title: 'Update Profile',
          fontSize: 20,
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: FutureBuilder(
            future: controller.getUsersData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userModel = snapshot.data as UserModel;
                  final email = TextEditingController(text: userModel.email);
                  final phone = TextEditingController(text: userModel.phone);
                  final name = TextEditingController(text: userModel.userName);
                  final id = TextEditingController(text: userModel.id);

                  return Column(
                    children: [
                      GetBuilder<ProfileController>(
                        builder: (controller) {
                          return Stack(
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 2, color: AppColors.iconsColor),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: controller.image == null
                                      ? userModel.photoUrl == ''
                                          ? Icon(
                                              Icons.person,
                                              size: 50,
                                              color: AppColors.iconsColor,
                                            )
                                          : Image(
                                              image: NetworkImage(
                                                  userModel.photoUrl),
                                              fit: BoxFit.cover,
                                            )
                                      : Image.file(
                                          File(controller.image!.path).absolute,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 0,
                                child: InkWell(
                                  onTap: () {
                                    controller.showImage(context, userModel);
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: AppColors.iconsColor,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.iconsColor,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        child: Column(
                          children: [
                            CustomTextField(
                                contr: name,
                                descrip: 'Name',
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                obsecure: false,
                                icon: Icons.person),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                                contr: email,
                                descrip: 'Email',
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                obsecure: false,
                                readOnly: true,
                                icon: Icons.email_outlined),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                                contr: phone,
                                descrip: 'Phone',
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.phone,
                                obsecure: false,
                                icon: Icons.phone),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return controller.state.loading.value == true
                            ? CircularProgressIndicator(
                                color: AppColors.iconsColor,
                              )
                            : RoundButton(
                                title: 'Save Profile',
                                onPress: () async {
                                  var userData = UserModel(
                                    id: id.text,
                                    email: email.text.trim(),
                                    phone: phone.text.trim(),
                                    userName: name.text.trim(),
                                    photoUrl:
                                        controller.state.userProfileImage == ''
                                            ? userModel.photoUrl.toString()
                                            : controller.state.userProfileImage,
                                  );
                                  await controller.updateUser(userData);
                                  // Get.to(() => PersonView());
                                },
                              );
                      }),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.iconsColor,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text('Error occurs');
                }
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.iconsColor,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
