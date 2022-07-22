import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
Widget TextEditField(BuildContext context, String text, bool ispass,
    TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    height: 40,
    child: TextField(
      controller: controller,
      obscureText: ispass,
      autofocus: false,
      style: GoogleFonts.cairo(color: Colors.white),
      textAlign: TextAlign.left,
      cursorHeight: 15,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        hintText: text,
        hintStyle: GoogleFonts.cairo(color: Colors.white),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.amberAccent, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(5)),
      ),
    ),
  );
}
