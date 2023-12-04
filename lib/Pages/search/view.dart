import 'package:e_services_fyp/Pages/search/controller.dart';
import 'package:e_services_fyp/Pages/search/widgets/search_widget.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:e_services_fyp/res/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchView extends GetView<SearchBarController> {
  SearchView({super.key});

  final controller = Get.put(SearchBarController());

  _searchField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: GetBuilder<SearchBarController>(builder: (con) {
          return TextField(
            controller: controller.state.searchController,

            textInputAction: TextInputAction.search,

            keyboardType: TextInputType.text,
            onChanged: (value) {
              con.searchServices(value);
            },
            style: GoogleFonts.poppins(
              fontSize: 17,
            ),

            // focusNode: focNode,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.iconsColor,
              ),
              border: InputBorder.none,
              hintText: 'Search services...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextWidget(
          title: 'Search',
        ),
        backgroundColor: AppColors.iconsColor,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _searchField(),
          Expanded(
            child: Obx(
              () => controller.filteredServicessList.length != 0
                  ? ListView.builder(
                      itemCount: controller.filteredServicessList.length,
                      itemBuilder: (context, index) {
                        print('Length iss :' +
                            controller.filteredServicessList.length.toString());
                        // Customize this part based on your data structure.
                        var service = controller.filteredServicessList[index];
                        print('service is : ' + service.toString());

                        String serviceId = service['id'].toString();
                        controller.getAverageRating(serviceId);
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SearchContainer(
                              serviceName: service['service'],
                              serviceLable: service['description'],
                              imageUrl: service['imageUrl'],
                              price: double.parse(
                                  service['hourlyRate'].toString()),
                              feedbackStars: controller
                                      .serviceAverageRatings[index]?.value ??
                                  0.0,
                              serviceProviderName: service['providerName'],
                              serviceProviderImage: service['providerImageUrl'],
                              pid: service['providerId']),
                        );
                      },
                    )
                  : Center(
                      child: TextWidget(
                          title: 'No searches yet',
                          textColor: AppColors.textColor,
                          fontSize: 25),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
