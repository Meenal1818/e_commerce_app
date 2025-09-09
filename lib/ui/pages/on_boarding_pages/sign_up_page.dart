

import 'package:e_commerce_app/domain%20(constants)/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain (constants)/ui_helper/signUpTextFieldStyle.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState>signUpKey=GlobalKey<FormState>();
  bool _obscureText=true;
 bool _confirmObscureText=true;
  String selectedGender= '';
  bool _isSelected=false;


  List<String> gender=['Male','Female','Other'];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: signUpKey,
              child: Container(
                padding:  EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.orange.shade100,spreadRadius: 3,blurRadius: 10,offset: Offset(3,3))]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/app_image/logo.png",height: 70,width: 70,fit: BoxFit.contain,),
                        SizedBox(width: 5,),
                        Text('E-Commerce',style: TextStyle(
                            color: Colors.orange,fontSize: 25,fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
        
                    SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      height: 70,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: emailController,
                        validator: (value){
                          RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                          if(value==null || value.isEmpty){
                            return 'Please enter email here...';
                          } else if(!emailRegex.hasMatch(value)) {
                            return 'Please enter valid email';
                          }else{
                            return null;
                          }
                        },
                        decoration: SignUpTextFieldStyle().textFieldDecoration(
                            label: 'Email', hint: 'Enter your email...', icon: Icons.email),
                      ),
                    ),
        
                    SizedBox(
                      width: 350,
                      height: 70,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return 'Please enter name here...';
                          }else{
                            return null;
                          }
                        },
                        decoration:  SignUpTextFieldStyle().textFieldDecoration(
                            label: 'Name', hint: 'Enter your name...', icon: CupertinoIcons.profile_circled),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 70,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: mobNoController,
                        validator: (value){
                          RegExp contactRegex = RegExp(r'^[6-9]\d{9}$');
        
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your contact number...';
                            }
                            // Match: +91 followed by space and 10-digit Indian number
                          else if (!contactRegex.hasMatch(value.trim())) {
                            return 'Enter a valid 10-digit number';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: SignUpTextFieldStyle().textFieldDecoration(
                          prefix: '+91 ',
                            label: 'Contact No.', hint: 'Enter your contact number...', icon: Icons.phone),
                      ),
                    ),
        
                    DropdownMenu(
                      width:350,
                        inputDecorationTheme: InputDecorationTheme(suffixIconColor: Colors.orange,
                          filled: true,
                          fillColor: Colors.orange[50],
                          labelStyle: TextStyle(color: Colors.black54, fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                          ),
                        ),
        
                        errorText: _isSelected && (selectedGender=='' || selectedGender.isEmpty)?'Please select gender...'
                            :null,
                        label: Text('Select Gender',style: TextStyle(color: Colors.orange),),
                        initialSelection: selectedGender ,
                        onSelected: (value){
                          setState(() {
                            selectedGender=value!;
                          });
                        },
        
                        dropdownMenuEntries: gender.map((e){
                      return DropdownMenuEntry(value: e, label: e);
                    }).toList() ),
        
        
                    SizedBox(height: 15,),
                    SizedBox(
                      width: 350,
                      height: 70,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: _obscureText,
                        validator: (value){
                          RegExp passRegex = RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'
                          );
                          if(value==null || value.isEmpty){
                            return 'Please enter password here...';
                          } else if (!passRegex.hasMatch(value)) {
                            return 'Password must be 8+ chars,\ninclude upper, lower, number & symbol';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.orange, fontSize: 15),
                          hintText: 'Enter your password...',
                          hintStyle: TextStyle(color: Colors.orange, fontSize: 15),
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
                            borderSide: BorderSide(color: Colors.orange), // same as enabled
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                              size: 20,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
        
                    SizedBox(
                      width: 350,
                      height: 70,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: confirmPassController,
                        obscureText: _confirmObscureText,
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return 'Enter your password again...';
                          }
                          else if(value != passwordController.text){
                            return 'Password is not same';
                          } else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.orange, fontSize: 15),
                          hintText: 'Enter your password...',
                          hintStyle: TextStyle(color: Colors.orange, fontSize: 15),
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
                            borderSide: BorderSide(color: Colors.orange), // same as enabled
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                              size: 20,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
        
                    SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if(signUpKey.currentState!.validate() && selectedGender =='' && selectedGender.isEmpty){
                            Navigator.pushReplacementNamed(context, AppRoutes.login);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
        
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(height: 1, width: 130, color: Colors.grey),
                        Text(
                          'OR',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                        ),
                        Container(height: 1, width: 130, color: Colors.grey),
                      ],
                    ),
        
                    SizedBox(height: 10),
        
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
                          'Sign Up with Gmail',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
        
                    SizedBox(height: 10),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ", // default text
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
        
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Log In',
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
      ),
    );
  }
}