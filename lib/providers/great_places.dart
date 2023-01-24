import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/db_helpers.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: '',
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }
}
