import 'package:e_services_fyp/Pages/OnBoardingPages/state.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final state = OnBoardingState();

  var currentPage = 0.obs;
  bool get isLastPage => currentPage.value == pages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {

      Get.offAllNamed(AppPages.signUpView);
    } else
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  skipAction() {
    Get.offAllNamed(AppPages.signUpView);
  }



  List<OnboardingPages> pages = [
    OnboardingPages(
      'assets/images/onboarding1.png',
      'Quick and easy Booking',
      'Now you can book your services \n any time right from your mobile',
    ),
    OnboardingPages(
      'assets/images/onboarding2.png',
      'Customer satisfaction is our top priority',
      'We provide professional Services\n'
          'at a friendly price',
    ),
    OnboardingPages(
      'assets/images/onboarding3.png',
      'Fast Services',
      'Services will be done quickly ',
    ),
  ];

  @override
  void Navigate() {
    Future.delayed(Duration(milliseconds: 300),
        () => Get.offAllNamed(AppPages.signUpView));
  }
}

class OnboardingPages {
  final String image;
  final String title;
  final String description;

  OnboardingPages(
      this.image,
      this.title,
      this.description);
}