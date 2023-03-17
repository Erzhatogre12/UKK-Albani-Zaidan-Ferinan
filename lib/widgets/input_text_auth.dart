
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTextAuth extends StatelessWidget {
  const InputTextAuth({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.keyboardType,
    required this.obscureText,
    required this.validator,
  });

  final controller;
  final placeholder;
  final keyboardType;
  final obscureText;
  final validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20,
        ),
        cursorColor:Colors.black,
        decoration: InputDecoration(
          hintText: '$placeholder',
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.black.withAlpha(100),
          ),
          hoverColor: Colors.black,
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     color: CustomAppTheme.color.black,
          //   ),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}