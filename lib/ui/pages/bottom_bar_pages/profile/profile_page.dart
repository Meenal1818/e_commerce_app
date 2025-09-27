import 'package:e_commerce_app/domain(constants)/app_routes.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Profile picture
            CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/147/147144.png'),
            ),
            const SizedBox(height: 40),

            // Profile details
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
                    title: Text('N/A'),
                  ),
                  Divider(color: Colors.white,thickness: 2,),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text('N/A'),
                  ),
                  Divider(color: Colors.white,thickness: 2,),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text('N/A'),
                  ),
                  Divider(color: Colors.white,thickness: 2,),
                  ListTile(
                    leading: const Icon(CupertinoIcons.cube_box_fill),
                    title: const Text('My Orders'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 25),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.myOrders);
                    },
                  ),
                  Divider(color: Colors.white,thickness: 2,),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('LogOut'),
                    onTap: () {
                      logout(context);
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

  //Logout with dialog box
  Future<void> logout(BuildContext context) async {
    bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel logout
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm logout
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );

    // If user confirmed
    if (confirmLogout == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.login, (Route<dynamic> route) => false);
    }
  }


}
