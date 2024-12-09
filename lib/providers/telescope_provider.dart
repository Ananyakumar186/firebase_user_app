import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../db/dbHelper.dart';
import '../models/brand_model.dart';
import '../models/image_model.dart';
import '../models/telescope.dart';

class TelescopeProvider with ChangeNotifier{
  List<Brand> brandList = [];
  List<Telescope> telescopeList = [];

  getAllBrands(){
    DbHelper.getAllBrands().listen((snapshot) {
      brandList = List.generate(snapshot.docs.length, (index) => Brand.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllTelescopes(){
    DbHelper.getAllTelescopes().listen((snapshot){
      telescopeList = List.generate(snapshot.docs.length, (index) => Telescope.fromJson(snapshot.docs[index].data()));
      // if (kDebugMode) {
      //   print("telescope list");
      //   debugPrint(jsonEncode(snapshot.docs[0].data()), wrapWidth: 1024);
      // }
      notifyListeners();
    });
  }

  Telescope findTelescopeById(String id) => telescopeList.firstWhere((element) => element.id == id);
}