import 'package:e_commerce_app/data(remote)/helper/api_helper.dart';
import 'package:e_commerce_app/data(remote)/repositary/cart_repo.dart';
import 'package:e_commerce_app/data(remote)/repositary/category_repo.dart';
import 'package:e_commerce_app/data(remote)/repositary/order_repo.dart';
import 'package:e_commerce_app/data(remote)/repositary/product_repo.dart';
import 'package:e_commerce_app/data(remote)/repositary/user_repo.dart';
import 'package:e_commerce_app/ui/bloc/cart/cart_bloc.dart';
import 'package:e_commerce_app/ui/bloc/category/category_bloc.dart';
import 'package:e_commerce_app/ui/bloc/order/order_bloc.dart';
import 'package:e_commerce_app/ui/bloc/product/product_bloc.dart';
import 'package:e_commerce_app/ui/bloc/user/user_bloc.dart';
import 'package:e_commerce_app/ui/pages/bottom_bar_pages/home/home_page.dart';
import 'package:e_commerce_app/ui/pages/on_boarding_pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain(constants)/app_routes.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  UserBloc(userRepository: UserRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create:
              (context) =>
                  ProductBloc(productRepo: ProductRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create:
              (context) => CategoryBloc(
                categoryRepo: CategoryRepo(apiHelper: ApiHelper()),
              ),
        ),
        BlocProvider(create: (context) => CartBloc(cartRepo: CartRepo(apiHelper: ApiHelper())),),
      BlocProvider(create: (context) => OrderBloc(orderRepo: OrderRepo(apiHelper: ApiHelper())),),

      ],
      child: MyApp(),
    ),
  );
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
    );
  }
}
