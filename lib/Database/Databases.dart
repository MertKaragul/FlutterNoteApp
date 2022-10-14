import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Android and IOS database import
import 'package:noteflutter/Database/AndroidDatabase/AndroidDatabase.dart';

import 'UserModel.dart';

class Databases {
  var CHANNEL = MethodChannel("samples.flutter.dev/database");
  var androidDatabase =
      new AndroidDatabase(MethodChannel("samples.flutter.dev/database"));

  Future<List<UserModel>> getDatabasesData() async {
    if (Platform.isAndroid) {
      return Future.value(androidDatabase.getDatabase());
    } else if (Platform.isIOS) {
      return Future.error("IOS database not already");
    } else {
      return Future.error("Database not found");
    }
  }

  Future<String> setInsertDataInDatabases(UserModel userModel) {
    if (Platform.isAndroid) {
      var insertStatus =  androidDatabase.insertDataDatabase(userModel.toJson());
      getDatabasesData();
      return insertStatus;
    } else if (Platform.isIOS) {
      return Future.error("IOS database not already");
    } else {
      return Future.error("Database not found");
    }
  }

  Future<String> deleteDataOnDatabases(id) async {
    if (Platform.isAndroid) {
      var deleteItemStatus = androidDatabase.deleteItemDatabase(id);
      getDatabasesData();
      return deleteItemStatus;
    } else if (Platform.isIOS) {
      return Future.error("IOS database not already");
    } else {
      return Future.error("Database not found");
    }
  }

  Future<String> updateDataOnDatabases(UserModel usermodel) async{
    if (Platform.isAndroid) {
      var updateStatus = androidDatabase.updateItemDatabase(usermodel);
      getDatabasesData();
      return updateStatus;
    } else if (Platform.isIOS) {
      return Future.error("IOS database not already");
    } else {
      return Future.error("Database not found");
    }
  }
}
