import 'dart:convert';

import 'package:flutter/services.dart';

import '../UserModel.dart';

class AndroidDatabase {
  late var methodChannel;

  AndroidDatabase(MethodChannel methodChannel) {
    this.methodChannel = methodChannel;
  }

  Future<List<UserModel>> getDatabase() async {
    try {
      List<UserModel> listUserModel = <UserModel>[];
      var getData = await methodChannel.invokeMethod("getDatabase") as String;
      var convertStringToList = jsonDecode(getData) as List<dynamic>;
      convertStringToList.forEach((element) {
        var convertToUserModel = UserModel.fromJson(element);
        listUserModel.add(convertToUserModel);
      });
      return Future.value(listUserModel);
    } catch (e) {
      print(e);
      return Future.error("Error");
    }
  }

  Future<String> insertDataDatabase(Map<String, dynamic> userModel) async {
    try {
      var addStatus = await methodChannel.invokeMethod("addDatabase", userModel);
      return Future.value(addStatus);
    } catch (e) {
      return Future.error("error");
    }
  }

  Future<String> deleteItemDatabase(int id) async {
    try {
      var deleteStatus = await methodChannel.invokeMethod(
          "removeDataOnDatabase", id) as String;
      return Future.value(deleteStatus);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> updateItemDatabase(UserModel userModel) async{
    try{
      var updateStatus = await methodChannel.invokeMethod("updateDataOnDatabase" , userModel.toJson());
      return Future.value(updateStatus);
    }catch(e){
      return Future.error(e);
    }
  }
}
