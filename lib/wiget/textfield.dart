/*
 * Copyright (C) 2021 NerdSpace, Inc. All Rights Reserved.
 *
 * Authors:
 *  Donam Kim <donam.kim@nerdspace.co.kr>
 *  Miji Cha <miji.cha@nerdspace.co.kr>
 *  Jaekyung Oh <jaekyung.oh@nerdspace.co.kr>
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;
  final TextInputType keyboardType;
  final bool isSecure;
  final TextEditingController controller;
  final bool isEnabled;

  CustomTextField(this.placeholder, this.keyboardType, this.isSecure, this.controller, {this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.0),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 25.0),
              _textField(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textField(BuildContext context) {
    return TextField(
      controller: this.controller,
      style: TextStyle(fontSize: 20.0, color: Colors.white),
      enabled: this.isEnabled,
      decoration: new InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC3C2C1))
        ),
        filled: true,
        hintText: this.placeholder,
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.black,fontWeight: FontWeight.bold),
      ),
      keyboardType: this.keyboardType,
      obscureText: this.isSecure,
    );
  }
}