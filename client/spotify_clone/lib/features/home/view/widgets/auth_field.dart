import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  const AuthField({Key? key
  , required this.hintText
  , required this.controller
  , this.isObscure = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
          ),
          validator: (value) => value!.isEmpty ? 'Please enter a valid $hintText' : null,
          controller: controller,
          focusNode: FocusNode(),
          obscureText: isObscure,
        );
        
  }
}