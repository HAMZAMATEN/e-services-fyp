import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/session_controller.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:e_services_fyp/service_provider_pages/offer_detail_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  String id;
  OrderDetailScreen({Key? key, required this.id}) : super(key: key);

  final ref = FirebaseFirestore.instance.collection('bookedServices');
  final controller = Get.put<OfferDetailController>(OfferDetailController());

  Widget _returnDetails(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 30.0),

          // Product or Order Icon in a Circle Avatar with shadow
          Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bookmark_border,
                  size: 50, color: AppColors.iconsColor),
            ),
          ),

          SizedBox(height: 25),

          // Using a card to make it pop a bit more
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    // _detailText('Order #', controller.orderDetails!.orderId.toString(), true),
                    _detailText('Customer Name',
                        snapshot.data!.docs[index]['userName'].toString()),
                    _detailText('Phone Number',
                        snapshot.data!.docs[index]['userPhone'].toString()),
                    _detailText('Address ',
                        snapshot.data!.docs[index]['lat'].toString()),
                    _detailText('Location ',
                        snapshot.data!.docs[index]['lang'].toString()),
                    _detailText(
                        'Date ',
                        controller.convertMillisecondsToDateFormat(
                            snapshot.data!.docs[index]['id'].toString())),
                    _detailText(
                        'Time ',
                        controller.convertTime(snapshot.data!.docs[index]['id'].toString()),
                        // controller.convertMillisecondsToHrsMM(
                        //     snapshot.data!.docs[index]['time'].toString())
                    ),
                    _detailText('Service ',
                        snapshot.data!.docs[index]['serviceName'].toString()),
                    _detailText('Description ',
                        snapshot.data!.docs[index]['description'].toString()),
                    _detailText('Status ',
                        snapshot.data!.docs[index]['status'].toString()),
                    SizedBox(
                        height: 15), // Provide some spacing before the button

                    // Button with styling
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showConfirmationDialog(context);
                          // print(SessionController().userId.toString());

                          // Get.to(()=>OrderItemsView(customerId:controller.orderDetails!.customerId, orderId: orderId));
                        }, // Implement the onTap functionality here
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.iconsColor,
                          primary: Colors.blue, // Background color
                          onPrimary: Colors.white, // Text color
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'Confirm Order',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailText(String label, String value,
      [bool isBold = false, Color? color]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '$label: ',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          SizedBox(width: 10,),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: color ?? Colors.black),
            ),
          ),
        ],
      ),
    );
  }


  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation',style: TextStyle(color: AppColors.iconsColor),),
          content: Text('Do you want to confirm or cancel this order?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                controller.cancelOrder(id, SessionController().userId.toString()).then((value){
                  Navigator.pop(context);
                });
               // Close the dialog
                // Handle rejection logic here
                // print('Order Rejected');
              },
              child: Text('Cancel',style: TextStyle(color: AppColors.rejectColor),),
            ),
            TextButton(
              onPressed: () {
                controller.confirmOrder(id, SessionController().userId.toString()).then((value){
                  Navigator.pop(context);
                });
                // Close the dialog


              },
              child: Text('Confirm',style: TextStyle(color: AppColors.accept),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Booking Details',
          fontSize: 20,
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: ref.where('id', isEqualTo: id).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(

                  color: AppColors.iconsColor,
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No data found'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, index) {
                  return _returnDetails(context, snapshot, index);
                });
          },
        ),
      ),
    );
  }
}
