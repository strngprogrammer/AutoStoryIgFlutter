// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
Widget MyTallButton(String text, Function fn) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top: 10),
    child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onPressed: () => {fn()},
      color: Colors.indigoAccent,
      splashColor: Colors.amber,
      padding: const EdgeInsets.only(left: 100, right: 100),
      child: Text(
        text,
        style: GoogleFonts.cairo(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

Widget MyShortButton(String text, Function fn) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top: 10),
    child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onPressed: () => {fn()},
      color: Colors.indigoAccent,
      splashColor: Colors.amber,
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Text(
        text,
        style: GoogleFonts.cairo(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}
