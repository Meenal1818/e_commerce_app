import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                trailing: const [Icon(Icons.tune, color: Colors.black)],
                elevation: MaterialStatePropertyAll(0),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 190,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: bannerList.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
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
                    ),

                    Positioned(
                      bottom: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(bannerList.length, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  _currentPage == index
                                      ? Colors.white
                                      : Colors.white54,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: 15,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.orange.shade400,
                                radius: 30,
                                child: Icon(
                                  CupertinoIcons.bag_fill,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),

                              Text(
                                'Shoes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
                    onPressed: () {},
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

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 10,bottom: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment. start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height:30,
                                width: 30,
                                decoration: BoxDecoration(borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10)
                                ),
                                color: Colors.orange),
                                child: Center(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                      onPressed: (){},
                                      icon: Icon(CupertinoIcons.heart,color: Colors.white,size: 20,)),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Image.asset(
                              'assets/app_image/logo.png',
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                          ),

                          SizedBox(height: 15,),
                          Text(
                            'Wireless Headphones',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: 12,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '\$140.00',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              SizedBox(width: 15,),
                              CircleAvatar(radius: 8,
                              backgroundColor: Colors.grey,),
                              SizedBox(width: 3,),
                              CircleAvatar(radius: 8,
                              backgroundColor: Colors.black,),
                              SizedBox(width: 3,),
                              CircleAvatar(radius: 8,
                              backgroundColor: Colors.red,),
                              SizedBox(width: 3,),
                              CircleAvatar(radius: 8,
                              backgroundColor: Colors.white,
                              child: Center(child: Text('2',style: TextStyle(fontSize: 10,
                              color: Colors.grey),)),)

                            ],
                          ),
                        ],
                      ),
                    );
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
