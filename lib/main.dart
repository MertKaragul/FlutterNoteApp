import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteflutter/Database/UserModel.dart';
import "package:noteflutter/Util/AppColors.dart";
import 'package:noteflutter/Util/TextWidget.dart';
import 'package:noteflutter/View/NoteDetailsPage.dart';

import 'Database/Databases.dart';
import 'Util/Buttons.dart';
import 'View/AddNoteView.dart';

void main() {
  runApp(MaterialApp(
    home: const mainPage(),
  ));
}

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  Databases databases = Databases();
  AppColors appColors = AppColors();
  late TextWidgets textWidgets;
  late Future<List<UserModel>> getDatabase;

  @override
  void initState() {
    super.initState();
    setState(() {
      getDatabase = databases.getDatabasesData();
    });
  }

  @override
  Widget build(BuildContext context) {
    late var query = MediaQuery.of(context).size;
    textWidgets = TextWidgets(query.height, query.width);
    return Scaffold(
      floatingActionButton: floatingActionButton(() => Navigator.push(context,MaterialPageRoute(builder: (context) => AddNoteView())) , Icons.add),
      body: SafeArea(
        child: Container(
          padding : EdgeInsets.only(left: 30, right: 30),
          height: query.height,
          child: Column(
            children: [
              textWidgets.titleText("Notes", appColors.TITLE_COLORS),
              FutureBuilder(
                future: getDatabase ,
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      return Flexible(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              getDatabase = databases.getDatabasesData();
                            });
                          },
                          child: Container(
                            height: query.height,
                            child: GridView.count(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              crossAxisCount: 2 ,
                              children: List.generate(snapshot.data?.length ?? 0, (index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Are you sure ? '),
                                        content: Text("${snapshot.data?[index].title} will be deleted"),
                                        actions: [
                                          TextButton(onPressed: () {
                                            Navigator.of(context).pop();
                                          }, child: Text("Cancel")),
                                          TextButton(onPressed: () {
                                            databases.deleteDataOnDatabases(snapshot.data?[index].id);
                                            Navigator.of(context).pop();
                                            setState(() {
                                              getDatabase = databases.getDatabasesData();
                                            });
                                          }, child: Text("Ok"))
                                        ],
                                      ),
                                    );
                                  },

                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => NoteDetailsPage(usermodel: snapshot.data![index])));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 10 , right: 10),
                                      decoration: BoxDecoration(color: appColors.COLUMN_COLORS , borderRadius: BorderRadius.circular(10),),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          textWidgets.columnTextTitle(_smallText(snapshot.data?[index].title ?? "" , (MediaQuery.of(context).size.width / 50)) , Colors.black),
                                          textWidgets.columnTextDescription(_smallText(snapshot.data?[index].description ?? "" , (MediaQuery.of(context).size.width / 2.5)) , Colors.black),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        width: query.width,
                        height: query.height / 1.2,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.note_add_sharp,
                                  size: (query.width * 0.25) , color: appColors.APPBAR_COLORS,),
                              textWidgets.bodyText(
                                  "You look not have note , please add note",
                                  Colors.black),
                              Padding(padding: EdgeInsets.all(10)),
                              textWidgets.noSizeText("Did you add a new note and came to this page?"),
                              TextButton(onPressed: (){ getDatabase = databases.getDatabasesData(); }, child: Text("Refresh" , style: TextStyle(color: appColors.TEXT_COLORS),))
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String _smallText(String text, double width) {
    String compressText = "";
    Characters toCharText = text.characters;
    if (toCharText.length >= width) {
      for (var i = 0; i <= toCharText.length; i++) {
        if (i <= width) {
          compressText += toCharText.elementAt(i);
        }
      }
      compressText += "...";
    } else {
      compressText = text;
    }
    return compressText;
  }
}
