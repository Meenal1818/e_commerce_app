import 'package:e_commerce_app/domain(constants)/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical:40,horizontal: 16),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: 20,),
            // Profile picture
            CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
            ),
            const SizedBox(height: 40),

            // Name and verification
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Name'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),

                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),

                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.cube_box_fill),
                    title: const Text('My Orders'),
                    trailing:  Icon(Icons.arrow_forward_ios,size: 25,),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.myOrders);
                    },
                  ),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

