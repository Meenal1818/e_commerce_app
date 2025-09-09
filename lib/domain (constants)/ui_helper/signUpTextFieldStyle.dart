import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpTextFieldStyle{
  InputDecoration textFieldDecoration(
  {required String label,required String hint,required IconData icon,String prefix=''}

      ){
    return InputDecoration(
      prefixText: prefix,
      prefixStyle: TextStyle(color: Colors.orange, fontSize: 15),
      labelText: label,
      labelStyle: TextStyle(color: Colors.orange, fontSize: 15),
      hintText: hint,
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
      suffixIcon: Icon(
        icon,
        size: 20,
        color: Colors.orange,
      ),
    );
  }

}

