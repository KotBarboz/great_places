import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final String location;
  final File image;
  final PlaceLocation? placeLocation;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
    this.placeLocation,
  });
}
