import 'package:e_commerce_app/data(remote)/model/category_model.dart';
import 'package:e_commerce_app/ui/bloc/category/category_bloc.dart';
import 'package:e_commerce_app/ui/bloc/category/category_event.dart';
import 'package:e_commerce_app/ui/bloc/product/product_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data(remote)/model/product_model.dart';
import '../../../domain(constants)/app_routes.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_state.dart';
import '../../custom_widgets/product_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  int? catId;
  String?catName;
  ProductModel? product;


  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)?.settings.arguments;

    if (args is List &&args.length>=2){

      catId = args[0]as int;
      catName=args[1]as String;

      context.read<ProductBloc>().add(FetchProductEvent(catId));
    }
    else if (args is ProductModel) {
      product =args;
      context.read<ProductBloc>().add(FetchProductEvent());
    }
    String title=catName??'All Products';
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 55, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                  title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 50),
                width: double.infinity,
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.orange),
                      );
                    }

                    if (state is ProductErrorState) {
                      return Center(child: Text(state.errorMsg));
                    }

                    if (state is ProductLoadedState) {
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 11,
                          crossAxisSpacing: 11,
                          childAspectRatio: 8 / 9,
                        ),
                        itemCount: state.mProductList.length,
                        itemBuilder: (_, index) {
                          final product = state.mProductList[index];
                          return ProductCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.details,
                                arguments: product,
                              );
                            },
                            imgPath: product.image!,
                            name: product.name!,
                            price: product.price!,
                          );
                        },
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
