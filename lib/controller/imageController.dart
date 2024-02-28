import 'package:flutter/material.dart';

class ImageController extends ChangeNotifier {

  var avatar;

  void update( var image) {

    avatar  = image;
    notifyListeners();

  }

}