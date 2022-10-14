import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteflutter/Database/AndroidDatabase/AndroidDatabase.dart';
import 'package:noteflutter/Database/Databases.dart';
import 'package:noteflutter/Database/UserModel.dart';
import 'package:noteflutter/Util/AppColors.dart';
import 'package:noteflutter/Util/TextWidget.dart';
import 'package:noteflutter/Util/TextFields.dart';

import '../Util/AppBars.dart';
import '../Util/Buttons.dart';
import '../Util/Snackbars.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  AppColors _appColors = AppColors();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late TextWidgets _textWidget;
  late double deviceHeight;
  Databases _databases = Databases();


  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    deviceHeight = query.height;
    _textWidget = TextWidgets(query.height, query.width);
    return Scaffold(
      appBar: appBar("Note App", true),
      body: SafeArea(
        child: Container(
          height: query.height,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20 , right: 20),
          decoration: BoxDecoration(color: _appColors.COLUMN_COLORS),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textFields(_titleController, "Title", false , query.height , true),
                Padding(padding: EdgeInsets.all(5)),
                textFields(_descriptionController, "Description", true , query.height , true),
                elevatedButton((){writeDataInDatabase();}, query.width, query.height),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void writeDataInDatabase(){
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    _setInsertDatabasesData(_titleController.text , _descriptionController.text)
        .then((value) => {scaffoldMessenger.showSnackBar(snackBar(value))})
        .onError((error, stackTrace) => {scaffoldMessenger.showSnackBar(snackBar(error.toString()))});
    Timer(Duration(seconds: 5), () {
      scaffoldMessenger.removeCurrentSnackBar();
    });
  }

  Future<String> _setInsertDatabasesData(String title , String description){
    if(title.isEmpty && description.isEmpty){
      return Future.error("Title and description error");
    }else{
      return _databases.setInsertDataInDatabases(UserModel(0, title, description, DateTime.now().toString()));
    }
  }



}
