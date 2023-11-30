import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/service_provider_pages/drawer/controller.dart';
import 'package:e_services_fyp/service_provider_pages/drawer/widgets/list_tile_widget.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/text_widget.dart';

class BuildDrawer {
  static Drawer buildDrawer(BuildContext context) {
    final con = Get.put(
      CustomDrawerController(),
    );
    return Drawer(
      width: 300,
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                TextWidget(
                  title: 'Hey , ',
                  fontSize: 16,
                  textColor: Colors.black,
                ),
                Obx(
                  () => TextWidget(
                    title: con.state.userName.value.toString().capitalizeFirst.toString(),
                    fontSize: 18,
                    textColor: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            // height: 30.sp,
            padding: EdgeInsets.symmetric(vertical: 0),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTileWidget(
            iconData: Icons.category_outlined,
            title: 'Categories',
            onPress: () {
              Navigator.pop(context);

              // Get.toNamed(AppRoutes.categoryScreen);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.shopping_cart_outlined,
            title: 'My Cart',
            onPress: () {
              Navigator.pop(context);
              // Get.toNamed(AppRoutes.cartScreen);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.person,
            title: 'My Profile',
            onPress: () {
              Navigator.pop(context);
              Get.toNamed(AppPages.providerProfileView);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.description_outlined,
            title: 'My Orders',
            onPress: () {
              Navigator.pop(context);
              // Get.toNamed(AppRoutes.orderScreen);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.error_outline_outlined,
            title: 'FAQs',
            onPress: () {
              Navigator.pop(context);
              // Get.toNamed(AppRoutes.faqsScreen);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.favorite_outline,
            title: 'Wish List',
            onPress: () {
              Navigator.pop(context);
              // Get.toNamed(AppRoutes.wishListScreen);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.help_outline_outlined,
            title: 'Help Center',
            onPress: () {
              Navigator.pop(context);
              // Get.toNamed(AppRoutes.helpCenterScreen);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTileWidget(
            iconData: Icons.logout,
            title: 'Log Out',
            onPress: () async {
              Navigator.pop(context);
              // final cartCon = Get.find<CartControllerReuseAble>();
              // cartCon.updateTotalPrice(0);
              // print('Price is : ' + cartCon.totalPrice.value.toString(),);
              // final detailCon = Get.put(DetailsController());
              // detailCon.itemIds.clear();
              // print('Items are : ' + detailCon.itemIds.toString());
              //
              // final CollectionReference collectionReference = FirebaseFirestore
              //     .instance
              //     .collection('users')
              //     .doc(FirebaseAuth.instance.currentUser!.uid)
              //     .collection('cartList');
              //
              //
              // final QuerySnapshot querySnapshot = await collectionReference.get();
              // for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
              //   await documentSnapshot.reference.delete().then((value) {
              //     print('Deleted success');
              //
              //
              //
              //   }).onError((error, stackTrace) {
              //     print('Error is : '+ error.toString());
              //   });
              // }
              //
              // final auth = FirebaseAuth.instance;
              // await auth.signOut().then((value) async {
              //
              //   SessionController().userId = '';
              //   Snackbar.showSnackBar("Logout", "Successfully");
              //
              //
              //   Get.offNamed(AppRoutes.logInScreen);
              //
              //
              //
              // }).onError(
              //       (error, stackTrace) {
              //     Snackbar.showSnackBar("Error", error.toString());
              //   },
              // );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     TextWidget(title: 'Light Theme'),
          //     GetBuilder<DarkThemeChanger>(builder: (cont) {
          //       return Switch(
          //           activeColor: LightAppColor.btnColor,
          //           value: cont.getDarkTheme,
          //           onChanged: (bool value) {
          //             cont.setDarkTheme = value;
          //             print('value is : ' + cont.getDarkTheme.toString().trim());
          //
          //             // Get.theme.
          //           });
          //     }),
          //     TextWidget(title: 'Dark Theme'),
          //   ],
          // )
        ],
      ),
    );
  }
}
