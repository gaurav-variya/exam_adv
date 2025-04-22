import 'dart:developer';
import 'package:exam_adv/model/receipe_model.dart';
import 'package:exam_adv/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class HomeController extends GetxController {
  List<ReceipeModel> allReceipe = [];

  Future<void>? insertData(String name, String description) async {
    int? res = await DBHelper.dbHelper.insertreceipe(name, description);

    if (res != null) {
      Get.snackbar('Success', 'Record has inserted',
          backgroundColor: Colors.green);
      // update();
      await fetchData();
    } else {
      Get.snackbar('Failed', 'Record was not inserted',
          backgroundColor: Colors.red);
    }
  }

  Future<List<ReceipeModel>> fetchData() async {
    allReceipe = await DBHelper.dbHelper.fetchRecord();
    for (var recipe in allReceipe) {
      log("Recipe: ID=${recipe.id}, Name=${recipe.name}, Description=${recipe.des}");
    }
    update();
    return allReceipe;
  }

  Future<void> updateData(ReceipeModel model) async {
    int? res = await DBHelper.dbHelper.updateRecord(model);
    if (res != null) {
      await fetchData();
      Get.snackbar('UPDATE', 'UPDATION was done successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('FAILED', 'UPDATION was failed',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future<void> deleteData(int id) async {
    int? res = await DBHelper.dbHelper.deleteRecord(id);
    if (res != null) {
      await fetchData();
      update();
      Get.snackbar('UPDATE', 'UPDATION was done successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('FAILED', 'UPDATION was failed',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
}
