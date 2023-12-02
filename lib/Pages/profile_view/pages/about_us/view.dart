import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/about_us/controller.dart';
import 'package:e_services_fyp/Pages/profile_view/pages/scheduled_services_view/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/text_widget.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'About Us',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title: 'Welcome to Your App Name!',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              TextWidget(
                title:
                    'At Your App Name, we are dedicated to simplifying your life by connecting you with skilled and trusted service providers in various domains. Whether it\'s repairing your smartphone, fixing electrical issues, solving plumbing woes, indulging in a salon experience, ensuring your comfort with AC repair services, and many more services , we\'ve got you covered.',
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              TextWidget(
                title:
                    'Our platform is designed to prioritize convenience, reliability, and quality. We handpick experienced professionals who are passionate about their work and committed to delivering exceptional service. Each service provider undergoes a rigorous vetting process to ensure they meet our standards of expertise and customer satisfaction.',
                fontSize: 16,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              TextWidget(
                title:
                    'With a simple and user-friendly interface, our app allows you to effortlessly browse through a diverse range of services. Explore detailed profiles of service providers, view their credentials, ratings, and customer feedback to make informed decisions that suit your requirements.',
                fontSize: 16,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              TextWidget(
                title:
                    'We understand the value of your time and the importance of a seamless service experience. Therefore, our goal is not just to fulfill your service needs but also to exceed your expectations. Whether it\'s a quick fix or a detailed service, we aim to deliver professionalism, reliability, and satisfaction with every interaction.',
                fontSize: 16,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              TextWidget(
                title:
                    'At Your App Name, we are committed to building a community where customers can rely on top-notch service providers and where service providers can showcase their skills, creating a mutually beneficial ecosystem.',
                fontSize: 16,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              TextWidget(
                title:
                    'Join us in simplifying your life and experiencing hassle-free services at your fingertips. Let Your App Name be your trusted companion in fulfilling all your service requirements.',
                fontSize: 16,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              TextWidget(
                title:
                    'Thank you for choosing Your App Name - Where Quality Meets Convenience!',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textColor: Colors.black,
              ),
              // You can add more Text widgets or other widgets as needed to further describe your app
            ],
          ),
        ),
      ),
    );
  }
}
