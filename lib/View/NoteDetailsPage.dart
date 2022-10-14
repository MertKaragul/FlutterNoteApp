import 'package:flutter/material.dart';
import 'package:noteflutter/Database/Databases.dart';
import 'package:noteflutter/Database/UserModel.dart';
import 'package:noteflutter/Util/TextFields.dart';
import '../Util/AppColors.dart';
import "package:noteflutter/Util/AppBars.dart";
import 'package:noteflutter/Util/Buttons.dart';

import '../Util/Snackbars.dart';

class NoteDetailsPage extends StatefulWidget {
  final UserModel usermodel;
  const NoteDetailsPage({Key? key , required this.usermodel}) : super(key: key);

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  AppColors appColors = AppColors();
  late TextEditingController textEditingTitle;
  late TextEditingController textEditingDescription;
  bool editStatus = false;
  Databases databases = Databases();

  @override
  void initState() {
    super.initState();
    setState(() {
      textEditingTitle = TextEditingController(text: widget.usermodel.title);
      textEditingDescription = TextEditingController(text: widget.usermodel.description);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(widget.usermodel.title, true),
      floatingActionButton: floatingActionButton(() {
        setState(() {
          var scaffoldMessenger = ScaffoldMessenger.of(context);
          if(editStatus) {
            databases.updateDataOnDatabases(UserModel(widget.usermodel.id ,textEditingTitle.text , textEditingDescription.text, DateTime.now().toString()))
                .then((value) {
                  if(value == "Data update complete"){
                    scaffoldMessenger.showSnackBar(snackBar(value));
                  }else{
                    scaffoldMessenger.showSnackBar(snackBar(value));
                  }
            });
            editStatus = false;
          }
          else editStatus = true;
        });
      } , editStatus ? Icons.save : Icons.edit) ,
      body: SafeArea(
        child: Container(
          height: size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20 , right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                textFields(textEditingTitle, "", false, size.height , editStatus),
                textFields(textEditingDescription, "", true, size.height , editStatus),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
