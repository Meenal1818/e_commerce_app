import 'package:e_commerce_app/ui/bloc/product/product_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 55,right: 15,left: 15),
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

                  SizedBox(width: 20,),
                  Text(
                    'Special For You',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 50),
                width: double.infinity,
                child:  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {

                      if(state is ProductLoadingState){
                        return Center(child: CircularProgressIndicator(color: Colors.orange,),);
                      }

                      if(state is ProductErrorState){
                        return Center(child: Text(state.errorMsg),);
                      }

                      if(state is ProductLoadedState){
                        return GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisSpacing: 11,
                            crossAxisSpacing: 11,
                            childAspectRatio: 8 / 9,
                          ),
                          itemCount: state.mProductList.length,
                          itemBuilder: (_, index) {
                            return ProductCard(
                              imgPath: state.mProductList[index].image!,
                              name: state.mProductList[index].name!,
                              price: state.mProductList[index].price!,
                            );
                          },
                        );
                      }

                      return Container();

                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
