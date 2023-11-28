import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/service_provider_pages/offer_detail_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferDetailScreen extends StatelessWidget {
  String id;
  OfferDetailScreen({Key? key, required this.id}) : super(key: key);

  final ref = FirebaseFirestore.instance.collection('scheduledServices');
  final controller = Get.put<OfferDetailController>(OfferDetailController());

  Widget _returnDetails(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50.0),

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

          SizedBox(height: 15),

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
                        snapshot.data!.docs[index]['name'].toString()),
                    _detailText('Phone Number',
                        snapshot.data!.docs[index]['phone'].toString()),
                    _detailText('Address ',
                        snapshot.data!.docs[index]['address'].toString()),
                    _detailText('Location ',
                        snapshot.data!.docs[index]['lat'].toString()),
                    _detailText(
                        'Date ',
                        controller.convertMillisecondsToDateFormat(
                            snapshot.data!.docs[index]['date'].toString())),
                    _detailText(
                        'Time ',
                        controller.convertMillisecondsToHrsMM(
                            snapshot.data!.docs[index]['time'].toString())),
                    _detailText('Service ',
                        snapshot.data!.docs[index]['service'].toString()),
                    _detailText('Description ',
                        snapshot.data!.docs[index]['serviceName'].toString()),
                    _detailText('Status ',
                        snapshot.data!.docs[index]['status'].toString()),
                    SizedBox(
                        height: 15), // Provide some spacing before the button

                    // Button with styling
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
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
                          'Confirm Details',
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
        children: [
          Expanded(
            child: Text(
              '$label: ',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: color ?? Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
