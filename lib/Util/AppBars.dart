import "package:flutter/material.dart";

import "AppColors.dart";

AppBar appBar(String title , bool centerTitle){
  return AppBar(
    title: Text(title),
    centerTitle: centerTitle,
    backgroundColor: AppColors().APPBAR_COLORS,
  );
}