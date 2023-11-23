import 'package:e_services_fyp/Pages/signup/bindings.dart';
import 'package:e_services_fyp/Pages/signup/view.dart';
import 'package:e_services_fyp/Pages/splashScreen/bindings.dart';
import 'package:e_services_fyp/Pages/splashScreen/view.dart';
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
      name: AppPages.signUpView,
      page: ()=> SignupView(),
      binding: SignupBindings(),
      transition: Transition.zoom,
    ),

  ];
}