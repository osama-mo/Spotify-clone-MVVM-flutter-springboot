import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final VoidCallback? onTap;
  final isReadOnly;
  const CustomTextField({Key? key
  , required this.hintText
  , required this.controller
  , this.isObscure = false
  , this.onTap
  , this.isReadOnly = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          readOnly: isReadOnly,
          onTap: onTap,
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