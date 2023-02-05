import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/db_helpers.dart';
import 'package:great_places/helpers/location_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String pickedTitle, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: address,
        image: image,
        placeLocation: updatedLocation);
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.placeLocation!.latitude,
        'loc_long': newPlace.placeLocation!.longitude,
        'address': newPlace.location,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');

    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: item['address'],
            placeLocation: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_long'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
