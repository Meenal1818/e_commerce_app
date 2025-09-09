import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> bannerList=[
    'assets/app_image/banner1.webp',
    'assets/app_image/banner2.jpg',
    'assets/app_image/banner3.jpg',
    'assets/app_image/banner4.jpg',
    'assets/app_image/banner6.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.grid_view_outlined,color: Colors.black,size: 25,),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(CupertinoIcons.bell,color: Colors.black,size: 25,),
                  ),
                ],
              ),

              SizedBox(height: 20,),
              SearchBar(
                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
                hintText: 'Search...',
                leading: const Icon(CupertinoIcons.search, color: Colors.grey),
                trailing: const [
                  Icon(Icons.tune, color: Colors.black),
                ],
                elevation: MaterialStatePropertyAll(0),
              ),

              SizedBox(height: 20,),

             SizedBox(
               height: 190,
               child: ListView.builder(
                 itemCount: bannerList.length,
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context, index) {
                 return  Padding(
                   padding: const EdgeInsets.only(right: 15),
                   child: Container(
                     height: 190,
                     width: 320,
                     decoration: BoxDecoration(
                         image: DecorationImage(image: AssetImage(bannerList[index]),fit: BoxFit.cover),
                         borderRadius: BorderRadius.circular(15)
                     ),
                   ),
                 );
               },),
             )


            ],
          ),
        ),
      ),
    );
  }
}
