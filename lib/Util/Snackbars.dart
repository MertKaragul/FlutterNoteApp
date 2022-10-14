import "package:flutter/material.dart";


SnackBar snackBar(String text) {
  return SnackBar(
    content: Text(text),
    action: SnackBarAction(onPressed: () {}, label: "Alright"),
  );
}
