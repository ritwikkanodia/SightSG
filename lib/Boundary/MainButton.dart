import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This method returns a main button for the User Interface
/// @param w This is the width of the button
/// @param h This is the height of the button
/// @param icon This is the icon of the button
/// @param text This is the text of the button
/// @param func This is the function of the button
/// @return File this is the temporory directory.
Widget mainButton(double w, double h, IconData icon, String text, Function func,
    EdgeInsets edgeInsets) {
  return Padding(
    padding: edgeInsets,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: w * 3, vertical: h * 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(h * 10),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white,
          child: ListTile(
            leading: Icon(
              icon,
              size: h * 5,
              color: Colors.white,
            ),
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: h * 3,
              ),
            ),
            onTap: () => func(),
          ),
        ),
      ),
    ),
  );
}
