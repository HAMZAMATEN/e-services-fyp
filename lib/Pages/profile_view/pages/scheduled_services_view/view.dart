import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/scheduled_services_view/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/text_widget.dart';

class ScheduledServicesScreen extends GetView<ScheduledServicesController> {
  Widget _buildlistTile(
    BuildContext context,
    String name,
    String phone,
    String service,
    String address,
    String date,
    String status,
    String time,
    String id,
  ) {
    Color statusColor;

    // Customize the color based on the order status
    switch (status) {
      case 'Delivered':
        statusColor = Colors.green;
        break;
      case 'Shipped':
        statusColor = Colors.orange;
        break;
      case 'Pending':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.black;
        break;
    }
    void _showOrderDetailsDialogue(BuildContext context) {
      final orderDetailsContent = Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            // Add order details such as image, name, etc. here
            // Example:
            SizedBox(
              height: 5,
            ),

            TextWidget(
              title: 'Service #' + id,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
            ),

            SizedBox(
              height: 5,
            ),
            TextWidget(
              title: 'User Name: ' + name,
              textColor: Colors.black,
            ),
            SizedBox(
              height: 5,
            ),

            TextWidget(
              title: 'Phone No: ' + phone.toString(),
              textColor: Colors.black,
            ),
            SizedBox(
              height: 5,
            ),
            TextWidget(
              title: 'Address: ' + address.toString(),
              textColor: Colors.black,
            ),
            SizedBox(
              height: 5,
            ),
            TextWidget(
              title: 'Service: ' + service,
              textColor: Colors.black,
            ),
            SizedBox(
              height: 5,
            ),
            TextWidget(
              title: 'Date: ' + date,
              textColor: Colors.black,
            ),
            SizedBox(
              height: 5,
            ),
            TextWidget(
              title: 'Time: ' + time,
              textColor: Colors.black,
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      );

      Get.defaultDialog(
        title: 'Service Details',
        content: orderDetailsContent,
        radius: 10.0,
        // cancelTextColor: Colors.orange,
        cancel: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            controller.cancelOrder(id);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              color: AppColors.iconsColor,
            ))),
            child: Center(
              child: TextWidget(
                  title: 'Cancel service', textColor: AppColors.iconsColor),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        _showOrderDetailsDialogue(context);
      },
      child: Card(
        margin: EdgeInsets.only(right: 16, left: 16, top: 12),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title: 'Service #' + id,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                textColor: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              TextWidget(
                title: 'User Name: ' + name,
                textColor: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              TextWidget(
                title: 'Phone No: ' + phone.toString(),
                textColor: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              TextWidget(
                title: 'Address: ' + address.toString(),
                textColor: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              TextWidget(
                title: 'Service: ' + service,
                textColor: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              TextWidget(
                title: 'Date: ' + date,
                textColor: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              TextWidget(
                title: 'Time: ' + time,
                textColor: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              TextWidget(
                title: 'Status: $status',
                textColor: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextWidget(
          title: 'Scheduled Services'
              '',
          fontSize: 18,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.firestore,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs.length != 0
                  ? Container(
                      child: ListView.builder(
                          // shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final date = int.parse(
                              snapshot.data!.docs[index]['date'],
                            );
                            final dateInMilli =
                                DateTime.fromMillisecondsSinceEpoch(date);
                            final formattedDate =
                                DateFormat('dd-MM-yy').format(dateInMilli);

                            DateTime dateTimeFromMilliseconds =
                                DateTime.fromMillisecondsSinceEpoch(
                              int.parse(
                                snapshot.data!.docs[index]['date'],
                              ),
                            );

                            // Formatting the DateTime object into a time string
                            String formattedTime = DateFormat("hh:mm a")
                                .format(dateTimeFromMilliseconds);

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: GestureDetector(
                                onTap: () {},
                                child: _buildlistTile(
                                  context,
                                  snapshot.data!.docs[index]['name'],
                                  snapshot.data!.docs[index]['phone'],
                                  snapshot.data!.docs[index]['service'],
                                  snapshot.data!.docs[index]['address'],
                                  formattedDate,
                                  snapshot.data!.docs[index]['status'],
                                  formattedTime,
                                  snapshot.data!.docs[index]['id'].toString(),
                                ),
                              ),
                            );
                          }),
                    )
                  : Column(
                      children: [
                        TextWidget(
                          title: 'No items here yet.',
                          fontSize: 28,
                        ),
                      ],
                    );
            } else if (snapshot.hasError) {
              print('Error : ' + snapshot.error.toString());
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
