import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteflutter/Util/AppColors.dart';


TextField textFields(
    TextEditingController controller, String hintText, bool isDescription , double deviceHeight , bool enabled) {
  return TextField(
    controller: controller,
    enabled: enabled ,
    maxLines: isDescription ? (deviceHeight * 0.025).toInt() : 1,
    keyboardType: TextInputType.multiline,
    style: GoogleFonts.nunito(color: Colors.black),
    decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10) , borderSide: BorderSide(color: AppColors().APPBAR_COLORS)),
        hintText: hintText),
  );
}