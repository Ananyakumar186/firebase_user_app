import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sklens_user_app/models/rating_model.dart';
import '../db/dbHelper.dart';
import '../models/app_user.dart';
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

  Future<void> addRating(String telescopeId,AppUser appUser, num rating) async{
    final ratingModel = Rating(appUser: appUser, rating: rating);
    await DbHelper.addRating(ratingModel, telescopeId);
    final snapshot = await DbHelper.getAllRatings(telescopeId);
    final List<Rating> ratingList = List.generate(snapshot.docs.length, (index) => Rating.fromJson(snapshot.docs[index].data()));
    num total = 0;
    for(final rate in ratingList) {
      total += rate.rating;
    }
    final avgRating = total / ratingList.length;
    return DbHelper.updateTelescopeField(telescopeId, {'avgRating': avgRating});
  }

  Telescope findTelescopeById(String id) => telescopeList.firstWhere((element) => element.id == id);
}