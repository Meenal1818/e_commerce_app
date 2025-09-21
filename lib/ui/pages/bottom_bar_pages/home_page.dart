import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/domain(constants)/app_routes.dart';
import 'package:e_commerce_app/ui/bloc/category/category_bloc.dart';
import 'package:e_commerce_app/ui/bloc/category/category_event.dart';
import 'package:e_commerce_app/ui/bloc/category/category_state.dart';
import 'package:e_commerce_app/ui/custom_widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../../bloc/product/product_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> bannerList = [
    'assets/app_image/banner1.webp',
    'assets/app_image/banner2.jpg',
    'assets/app_image/banner3.jpg',
    'assets/app_image/banner4.jpg',
    'assets/app_image/banner6.jpg',
  ];
  int _currentIndex = 0;
  bool isBuild=true;
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductEvent());
    context.read<CategoryBloc>().add(GetAllCategory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.grid_view_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      CupertinoIcons.bell,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              SearchBar(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 10),
                ),
                hintText: 'Search...',
                leading: const Icon(CupertinoIcons.search, color: Colors.grey),
                trailing:  [
                  Container(height: 25,
                  width: 2,
                  decoration: BoxDecoration(color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)),),
                SizedBox(width: 13,),
                Icon(Icons.tune, color: Colors.black)],
                elevation: MaterialStatePropertyAll(0),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 190,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider.builder(itemCount: bannerList.length,
                        itemBuilder: (_, index, __) {
                         return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(bannerList[index]),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index,_){
                            _currentIndex=index;
                            setState(() {

                            });
                          },
                          autoPlay: true,
                          height: 200,
                          viewportFraction: 1,
                          autoPlayCurve:Curves.fastOutSlowIn,
                          autoPlayInterval: Duration(seconds: 4)
                        )),

                    Positioned(
                      bottom: 12,
                      child: DotsIndicator(dotsCount: bannerList.length,
                      position: _currentIndex.toDouble(),
                      animate: true,
                      decorator: DotsDecorator(
                        activeSize: Size(18, 8),
                        size: Size(8, 8),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.transparent,
                        activeColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                          side: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        spacing: EdgeInsets.only(
                          right: 3,
                          top: 11,
                          bottom: 11,
                        ),
                      ),)
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 115,
                child: BlocBuilder<CategoryBloc,CategoryState>(
                  builder: (context, state) {
                  if(state is CategoryLoadingState){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(state is CategoryErrorState){
                    return Center(child: Text(state.errorMsg));
                  }
                  if(state is CategoryLoadedState){
                    return state.mCategoryList.isNotEmpty?
                    ListView.builder(
                      itemCount: state.mCategoryList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        int categoryId= int.parse(state.mCategoryList[index].id!);
                        String categoryName= state.mCategoryList[index].name!;
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      isBuild=false;
                                      Navigator.pushNamed(context, AppRoutes.category,arguments:[categoryId,categoryName]);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.orange.shade400,
                                      radius: 30,
                                      child: Icon(
                                        CupertinoIcons.bag_fill,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                        state.mCategoryList[index].name!,
                                        style: TextStyle(
                                          overflow:TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ):
                    Center(child: Text('No Categories Found.'),);
                  }
                  return Container();
                },)
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special For You',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.category);
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),

          Container(
            margin: EdgeInsets.only(top: 10, bottom: 150),
            width: double.infinity,
            child: BlocBuilder<ProductBloc, ProductState>(
                buildWhen: (ps,cs){
                  return isBuild;
                },
                builder: (context, state) {

                  if(state is ProductLoadingState){
                    return Center(child: CircularProgressIndicator(color: Colors.orange,),);
                  }

                  if(state is ProductErrorState){
                    return Center(child: Text(state.errorMsg),);
                  }

                  if(state is ProductLoadedState){
                    return state.mProductList.isNotEmpty?
                    GridView.builder(
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
                          onTap: (){
                            Navigator.pushNamed(context, AppRoutes.details,arguments: state.mProductList[index]);
                          },
                          imgPath: state.mProductList[index].image!,
                          name: state.mProductList[index].name!,
                          price: '₹${state.mProductList[index].price!}',
                        );
                      },
                    ):
                    Center(child: Text('No Data Found.'));
                  }

                  return Container();

                }
            ),
          )],
          ),
        ),
      ),
    );
  }
}
