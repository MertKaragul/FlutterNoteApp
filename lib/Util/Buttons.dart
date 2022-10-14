import 'package:flutter/material.dart';

import 'AppColors.dart';

ElevatedButton elevatedButton(VoidCallback onPress, double height, double width) {
  return ElevatedButton(
    onPressed: ()=> onPress(),
    child: Container(
      width: width,
      height: (height * 0.05),
      alignment: Alignment.center,
      child: Text("Save"),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors().APPBAR_COLORS),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.transparent),
        ),
      ),
    ),
  );
}

FloatingActionButton floatingActionButton(VoidCallback onPress , IconData icons) {
  return FloatingActionButton(
    onPressed: () => onPress(),
    backgroundColor: AppColors().APPBAR_COLORS,
    child: Icon(icons),
  );
}
