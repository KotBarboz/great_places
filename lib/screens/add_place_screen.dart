import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double long) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new Place'),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ImageInput(_selectImage),
                      const SizedBox(
                        height: 10,
                      ),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _savePlace,
              style: ButtonStyle(
                iconColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColorDark),
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
                shape: MaterialStateProperty.all(const CircleBorder()),
                elevation: MaterialStateProperty.all(0),
              ),
              child: const Icon(Icons.add),
            )
          ],
        ));
    ;
  }
}
