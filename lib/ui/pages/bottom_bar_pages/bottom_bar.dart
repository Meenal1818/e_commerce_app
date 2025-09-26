import 'package:e_commerce_app/ui/pages/bottom_bar_pages/cart/cart_page.dart';
import 'package:e_commerce_app/ui/pages/bottom_bar_pages/home/home_page.dart';
import 'package:e_commerce_app/ui/pages/bottom_bar_pages/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        _selectedIndex=2;
        setState(() {
        });
      },
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Icon(Icons.home_outlined,),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        elevation: 21,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                _selectedIndex = 0;
                setState(() {});
              },
              icon: Icon(
                _selectedIndex == 0
                    ? Icons.dashboard_customize
                    : Icons.dashboard_customize_outlined,
                color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
              ),
            ),

            IconButton(
              onPressed: () {
                _selectedIndex = 1;
                setState(() {});
              },
              icon: Icon(
                _selectedIndex == 1
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
                color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
              ),
            ),

            SizedBox(width: 50,),

            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
              },
              icon: Icon(
                _selectedIndex == 3
                    ? CupertinoIcons.cart_fill
                    : CupertinoIcons.cart,
                color: _selectedIndex == 3 ? Colors.orange : Colors.grey,
              ),
            ),

            IconButton(
              onPressed: () {
                _selectedIndex = 4;
                setState(() {});
              },
              icon: Icon(
                _selectedIndex == 4
                    ? Icons.person
                    : CupertinoIcons.person,
                color: _selectedIndex == 4 ? Colors.orange : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
