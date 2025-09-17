import 'package:e_commerce_app/ui/bloc/user/user_bloc.dart';
import 'package:e_commerce_app/ui/bloc/user/user_event.dart';
import 'package:e_commerce_app/ui/bloc/user/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain(constants)/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isLogin = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade100,
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // SizedBox(height: 120),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.orange,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Stay signed in with your account \n      to make searching easier.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    height: 80,
                    child: TextFormField(
                      validator: (value) {
                        RegExp emailRegex = RegExp(
                          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                        );
                        if (value == null || value.isEmpty) {
                          return 'Please enter email here..';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Please enter valid email';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                        ),
                        filled: true,
                        fillColor: Colors.orange.shade50,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          // same as enabled
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: Icon(
                          CupertinoIcons.profile_circled,
                          size: 20,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 350,
                    height: 80,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password here..';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      controller: passwordController,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                        ),
                        filled: true,
                        fillColor: Colors.orange.shade50,

                        enabled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          // same as enabled
                          borderRadius: BorderRadius.circular(10),
                        ),

                        // Eye Icon to toggle password
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            size: 20,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: BlocConsumer<UserBloc, UserState>(
                      listenWhen: (ps, cs) {
                        return isLogin;
                      },
                      buildWhen: (ps, cs) {
                        return isLogin;
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              isLogin = true;
                              context.read<UserBloc>().add(LoginUserEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:  isLoading ? Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(),
                              Text('Logging-in...',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),)
                            ],
                          ) : Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      listener: (_, state) {
                        if (state is UserLoadingState) {
                          isLoading = true;
                        }

                        if (state is UserFailureState) {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMsg),
                            backgroundColor: Colors.red,));
                        }

                        if (state is UserSuccessState) {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Login successfully'),
                            backgroundColor: Colors.green,));
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.bottomBar);
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(height: 1, width: 130, color: Colors.grey),
                      Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 18,
                        ),
                      ),
                      Container(height: 1, width: 130, color: Colors.grey),
                    ],
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          'assets/app_image/icons8-gmail-48 (1).png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Log in with Gmail',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),

                  SizedBox(height: 60),

                  Text(
                    'Forget Password?',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),

                  SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ", // default text
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signUp);
                        },
                        child: Text(
                          'Sign UP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
