import 'package:flutter/material.dart';

Widget getEmptyViewWidget(String emptyViewText) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/question_pixel_art.png",
          height: 200.0,
          width: 200.0,
        ),
        const SizedBox(
          height: 50.0,
        ),
        RichText(
          text: TextSpan(
            text: emptyViewText,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
              fontSize: 20.0,
              letterSpacing: 2.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
