import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidgets{
  var deviceHeight;
  var deviceWidth;

  TextWidgets(double deviceHeight , double deviceWidth ){
    this.deviceHeight = deviceHeight;
    this.deviceWidth = deviceWidth;
  }


  Text titleText(String text , Color color){
    return Text(text , style: GoogleFonts.nunito(fontStyle: FontStyle.normal , fontWeight: FontWeight.w700 , fontSize: deviceWidth * 0.15 , color: color));
  }

  Text bodyText(String text , Color color){
    return Text(text , style: GoogleFonts.nunito(fontStyle: FontStyle.normal , fontSize: deviceWidth * 0.04 , color: color));
  }

  Text columnTextTitle(String text , Color color){
    return Text(text , style: GoogleFonts.nunito(fontStyle: FontStyle.normal , fontWeight: FontWeight.w500 , fontSize: deviceWidth * 0.055, color: color));
  }

  Text columnTextDescription(String text , Color color){
    return Text(text , style: GoogleFonts.nunito(fontStyle: FontStyle.normal , fontWeight: FontWeight.w100 , fontSize: deviceWidth * 0.032 , color: color));
  }

  Text noSizeText(String text){
    return Text(text , style: GoogleFonts.nunito(),);
  }

}