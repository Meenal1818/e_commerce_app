import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/ui/bloc/cart/cart_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data(remote)/model/product_model.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_state.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _currentIndex = 0;
  int selectedIndex = 0;
  int pageViewIndex = 0;
  bool isLoading=false;
  final PageController _pageController = PageController();

  final tabs = ["Description", "Specifications", "Reviews"];

  List<Color> mColors = [
    Colors.black,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.cyan
  ];
  int quantity=1;


  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)?.settings.arguments as ProductModel;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [

                        //Product Images
                        CarouselSlider.builder(
                          itemCount: 5,
                          itemBuilder: (_, index, __) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                // image: DecorationImage(
                                //   image: NetworkImage(args.image!),
                                //   fit: BoxFit.none,
                                // ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.network(args.image!,height: 250,width: 250,fit: BoxFit.contain,),
                            );
                          },
                          options: CarouselOptions(
                            onPageChanged: (index, _) {
                              _currentIndex = index;
                              setState(() {});
                            },
                            // autoPlay: true,
                            height: 350,
                            viewportFraction: 1,
                            // autoPlayCurve:Curves.fastOutSlowIn,
                            // autoPlayInterval: Duration(seconds: 4)
                          ),
                        ),

                        //Back, share, like, Icons UI
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      CupertinoIcons.back,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Spacer(),

                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.share_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),

                                SizedBox(width: 10),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //Dot Indicator
                        Positioned(
                          bottom: 12,
                          child: DotsIndicator(
                            dotsCount: 5,
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
                                side: BorderSide(color: Colors.black, width: 1),
                              ),
                              spacing: EdgeInsets.only(right: 3, top: 11, bottom: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Product name, price, rating, seller name UI
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text('${args.name}\n₹${args.price}',style: TextStyle(
                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
                                  ),
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow:TextOverflow.ellipsis,),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(CupertinoIcons.star_fill,color: Colors.white,size: 12,),
                                          Text(' 4.8',style: TextStyle(
                                              color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold
                                          ),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),

                                    Text('(320 Review)',style: TextStyle(
                                        color: Colors.grey,fontSize: 15,
                                    ),),
                                  ],
                                )
                              ],
                            ),

                            Text('Seller: Meenal Mathur',style: TextStyle(
                                color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500
                            ),),
                          ],
                        ),

                        SizedBox(height: 25,),

                        //Colors UI
                        Text('Color',style: TextStyle(
                            color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold
                        ),),

                        SizedBox(height: 10,),

                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: mColors.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  selectedIndex = index;
                                  setState(() {});
                                },
                                child: selectedIndex == index
                                    ? Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: mColors[index],
                                      width: 2,
                                    ),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: mColors[index],
                                    ),
                                  ),
                                )
                                    : Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: mColors[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 25,),

                        //PageView UI
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(tabs.length, (index) {
                            final isSelected = pageViewIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() => pageViewIndex = index);
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.orange : Colors.transparent,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child:  Center(
                                      child: Text(
                                        tabs[index],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 15),

                        // PageView
                        SizedBox(
                          height: 500,
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() => pageViewIndex = index);
                            },
                            children: [
                              // Description
                              Text(
                                "Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.",
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              ),

                              // Specifications
                              Text(
                                "Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.",
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              ),

                              // Reviews
                              Text(
                                "Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.Lorem ipsum dolor sit amet consectetur. "
                                    "Placerat in semper vitae a. Blandit amet purus eget "
                                    "sed vitae morbi tellus.",
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),




                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),


          //Bottom Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Row(
                  children: [

                    //Quantity UI
                    Container(
                      width: 110,
                      height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove,color: Colors.white,size: 20,),
                            onPressed: () {
                              if (quantity > 1) {

                                setState(() => quantity--);
                              }
                            },
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add,color: Colors.white,size: 20,),
                            onPressed: () {
                              setState(() => quantity++);
                            },
                          ),
                        ],
                      ),
                    ),

                    Spacer(),

                    //Add to cart button UI
                    SizedBox(
                      height: 60,
                      width: 200,
                      child:   BlocConsumer<CartBloc, CartState>(
                        listener: (_, state) {
                          if (state is CartLoadingState) {
                            isLoading = true;
                          }

                          if (state is CartFailureState) {
                            isLoading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMsg),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }

                          if (state is CartSuccessState) {
                            isLoading = false;
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Item added to cart successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        }, builder: (context,state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                AddToCart(
                                  productId: int.parse(args.id),
                                  qty: quantity,
                                ),
                              );
                            },
                            child: isLoading ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("Adding...",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),),
                              ],
                            ) : Text(
                              "Add To Cart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          );
                      },

                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}


