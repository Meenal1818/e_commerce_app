import 'package:e_commerce_app/data(remote)/helper/api_helper.dart';
import 'package:e_commerce_app/data(remote)/repositary/user_repo.dart';
import 'package:e_commerce_app/ui/bloc/user/user_bloc.dart';
import 'package:e_commerce_app/ui/pages/bottom_bar_pages/home_page.dart';
import 'package:e_commerce_app/ui/pages/on_boarding_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain(constants)/app_routes.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => UserBloc(userRepository: UserRepo(apiHelper: ApiHelper())),)
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.getRoutes(),
      debugShowCheckedModeBanner: false,
      home: SplashPage()
    );
  }
}


