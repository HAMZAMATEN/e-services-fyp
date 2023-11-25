import 'package:e_services_fyp/Pages/OnBoardingPages/bindings.dart';
import 'package:e_services_fyp/Pages/OnBoardingPages/view.dart';
import 'package:e_services_fyp/Pages/application_view/bindings.dart';
import 'package:e_services_fyp/Pages/application_view/view.dart';
import 'package:e_services_fyp/Pages/catogery_view/bindings.dart';
import 'package:e_services_fyp/Pages/catogery_view/view.dart';
import 'package:e_services_fyp/Pages/home/bindings.dart';
import 'package:e_services_fyp/Pages/home/view.dart';
import 'package:e_services_fyp/Pages/profile_view/bindings.dart';
import 'package:e_services_fyp/Pages/profile_view/view.dart';
import 'package:e_services_fyp/Pages/scheduled_view/bindings.dart';
import 'package:e_services_fyp/Pages/scheduled_view/view.dart';
import 'package:e_services_fyp/Pages/signup/bindings.dart';
import 'package:e_services_fyp/Pages/signup/view.dart';
import 'package:e_services_fyp/Pages/splashScreen/bindings.dart';
import 'package:e_services_fyp/Pages/splashScreen/view.dart';
import 'package:e_services_fyp/service_provider_pages/provider_home/bindings.dart';
import 'package:e_services_fyp/service_provider_pages/provider_home/view.dart';
import 'package:e_services_fyp/utils/routes/routesNames.dart';
import 'package:get/get.dart';

class AppRoutes{
  static final List<GetPage> routes = [

    GetPage(
      name: AppPages.splashView,
        page: ()=> SplashView(),
      binding: SplashBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppPages.onBoardingView,
      page: ()=> OnBoardingView(),
      binding: OnBoardingBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppPages.signUpView,
      page: ()=> SignupView(),
      binding: SignupBindings(),
      transition: Transition.zoom,
    ),

    GetPage(
      name: AppPages.applicationView,
      page: ()=> ApplicationView(),
      binding: ApplicationBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppPages.scheduledView,
      page: ()=> ScheduledView(),
      binding: ScheduledBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppPages.catogeryView,
      page: ()=> CategoryView(),
      binding: CatogeryBindings(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppPages.homeView,
      page: ()=> HomeView(),
      binding: HomeBindings(),
      transition: Transition.zoom,
    ),

    GetPage(
      name: AppPages.userProfileView,
      page: ()=> ProfileView(),
      binding: ProfileBindings(),
      transition: Transition.zoom,
    ),

    GetPage(
      name: AppPages.providerHomeView,
      page: ()=> SPHomeView(),
      binding: SPHomeBindings(),
      transition: Transition.zoom,
    ),

  ];
}