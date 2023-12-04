import 'package:e_services_fyp/Pages/OnBoardingPages/controller.dart';
import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
              children: [
            PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.currentPage,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5.0),
                    // height: 50,
                    // width: 50,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            controller.pages[index].image,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(controller.pages[index].title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor)),
                          SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 64.0),
                            child: Text(
                              controller.pages[index].description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                            ),
                          ),
                        ]),
                  );
                }),
            Positioned(
              bottom: 50,
              left: 20,
              child: Row(
                children: List.generate(
                  controller.pages.length,
                  (index) => Obx(() {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.currentPage.value == index
                              ? AppColors.iconsColor
                              : AppColors.grey),
                    );
                  }),
                ),
              ),
            ),
            Obx((){
              return Positioned(
                right: 15,
                bottom: 30,
                child: Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                      // color: AppColors.primaryColor, //Colors.blueAccent,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextButton(
                    onPressed: () => controller.forwardAction(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          controller.isLastPage ? 'Start' : 'Next',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.iconsColor),
                        ),
                        Icon(Icons.keyboard_arrow_right_outlined,color: AppColors.grey,size: 30,)
                      ],
                    ),
                  ),
                ),
              );
            }),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                height: 60,
                // width: 80,
                decoration: BoxDecoration(
                    // color: AppColors.primaryColor, //Colors.blueAccent,
                    borderRadius: BorderRadius.circular(25)),
                child: TextButton(
                  //splashColor: AppColors.secondaryColor,
                  onPressed: () => controller.skipAction(),
                  child: Row(
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.iconsColor,
                        ),
                      ),
                      // Icon(Icons.keyboard_tab,color: AppColors.grey,size: 30,),

                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
