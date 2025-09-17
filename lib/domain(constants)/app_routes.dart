

import 'package:e_commerce_app/ui/pages/bottom_bar_pages/category_page.dart';
import 'package:e_commerce_app/ui/pages/bottom_bar_pages/details_page.dart';
import 'package:flutter/cupertino.dart';

import '../ui/pages/bottom_bar_pages/bottom_bar.dart';
import '../ui/pages/bottom_bar_pages/home_page.dart';
import '../ui/pages/on_boarding_pages/login_page.dart';
import '../ui/pages/on_boarding_pages/sign_up_page.dart';
import '../ui/pages/on_boarding_pages/splash_screen.dart';

class AppRoutes{

  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String bottomBar = '/bottomBar';
  static const String home = '/home';
  static const String details = '/details';
  static const String category = '/category';




  static Map<String, WidgetBuilder> getRoutes() => {
    splash: (context) => SplashPage(),
    login: (context) => LoginPage(),
    signUp: (context) => SignUpPage(),
    bottomBar:(context)=> BottomBar(),
    home:(context)=> HomePage(),
    details:(context)=> DetailsPage(),
    category:(context)=>  CategoryPage(),

  };

}