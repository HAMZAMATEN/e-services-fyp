import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../res/colors.dart';
import '../../../../res/text_widget.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'FAQ\'s',
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

      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FAQItem(
            question: 'What services do you offer?',
            answer:
            'We provide smartphone repairs, electrician services, plumbing solutions, salon services, and AC repair.',
          ),
          FAQItem(
            question: 'How can I find a service provider?',
            answer:
            'Browse our app to find providers in your area. Filter by service type and view provider profiles to make an informed decision.',
          ),
          FAQItem(
            question: 'Are the service providers vetted?',
            answer:
            'Yes, all service providers undergo a rigorous vetting process to ensure expertise, professionalism, and customer satisfaction.',
          ),
          FAQItem(
            question: 'How do I schedule a service?',
            answer:
            'Contact a service provider directly through our app to schedule an appointment once you find a suitable provider.',
          ),
          FAQItem(
            question: 'Is there a rating system for providers?',
            answer:
            'Yes, you can rate and leave feedback for providers based on your experience, helping us maintain service quality.',
          ),
          FAQItem(
            question: 'What are the payment options available?',
            answer:
            'We support various payment methods such as credit/debit cards, mobile wallets, and in some cases, cash payments.',
          ),
          FAQItem(
            question: 'Can I cancel or reschedule a booked service?',
            answer:
            'Yes, you can cancel or reschedule a service booking by contacting the service provider through our app.',
          ),
          FAQItem(
            question: 'Is there a guarantee for the services provided?',
            answer:
            'We strive for customer satisfaction. In case of any issues, contact us, and we will assist in resolving the matter.',
          ),
          // Add more FAQ items as needed
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TextWidget(title:
        question,
          textColor: Colors.black,
        fontWeight: FontWeight.bold),

      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextWidget(title: answer,textColor: Colors.black,),
        ),
      ],
    );
  }
}