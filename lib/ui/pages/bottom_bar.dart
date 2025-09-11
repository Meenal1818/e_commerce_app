import 'package:e_commerce_app/ui/pages/bottom_bar_pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain(constants)/app_routes.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
  Center(child: Text('Widget Page')),
    Center(child: Text('Notification Page')),
    HomePage(),
    Center(child: Text('Cart Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,
        onTap: (index) {
            _selectedIndex = index;
            setState(() {

            });
        },
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.widgets_outlined),
            label: ''
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
              label: ''
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  color:_selectedIndex ==2 ? Colors.orange:Colors.grey.shade500 ,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(Icons.home_outlined,color:Colors.white,size: 25,),
            ),
              label: ''
          ),

          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart),
              label: ''
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
              label: ''
          ),
        ],
      ),
    );
  }
}
