import 'package:e_commerce_app/domain(constants)/app_routes.dart';
import 'package:e_commerce_app/ui/bloc/user/user_bloc.dart';
import 'package:e_commerce_app/ui/bloc/user/user_event.dart';
import 'package:e_commerce_app/ui/bloc/user/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserSuccessState) {
            final user = state.user;

            return SingleChildScrollView(
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
                    backgroundImage: NetworkImage(user!.image ?? ''),
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
                          title: Text(user.name ?? 'N/A'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Text(user.email ?? 'N/A'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(user.mobileNumber ?? 'N/A'),
                        ),
                        ListTile(
                          leading: const Icon(CupertinoIcons.cube_box_fill),
                          title: const Text('My Orders'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 25),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.myOrders);
                          },
                        ),
                        ListTile(
                          leading: const Icon(CupertinoIcons.cube_box_fill),
                          title: const Text('LogOut'),
                          trailing: const Icon(Icons.logout, size: 25),
                          onTap: () {
                           logout(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserFailureState) {
            return Center(child: Text("Error: ${state.errorMsg}"));
          }

          return const SizedBox();
        },
      ),
    );
  }

  //Logout
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (Route<dynamic> route) => false,);
  }

}
