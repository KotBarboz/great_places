import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:great_places/models/place.dart';
import 'package:latlng/latlng.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.433, longitude: -122.085),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // late double initLatitude = widget.initialLocation.latitude;
  LatLng? _pickedLocation;

  final MapController _mapController = MapController(
    initMapWithUserPosition: true,
    // initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    // areaLimit: BoundingBox(
    //   east: 10.4922941,
    //   north: 47.8084648,
    //   south: 45.817995,
    //   west: 5.9559113,
    // ),
  );

  @override
  void initState() {
    // _mapController.addObserver(this);
    // _mapController.listenerMapLongTapping.addListener(() {
    //   if (_mapController.listenerMapLongTapping.value != null) {
    //     print('-----------------------------------------------');
    //   }
    // });
    // _mapController.listenerMapSingleTapping.addListener(() {
    //   if (_mapController.listenerMapSingleTapping.value != null) {
    //     /// put you logic here
    //   }
    // });

    // _mapController.listenerMapLongTapping.addListener(() async {
    //   if (_mapController.listenerMapLongTapping.value != null) {
    //     print(_mapController.listenerMapLongTapping.value);
    //     final randNum = Random.secure().nextInt(100).toString();
    //     print(randNum);
    //     await _mapController.addMarker(
    //       _mapController.listenerMapLongTapping.value!,
    //       markerIcon: MarkerIcon(
    //         iconWidget: SizedBox.fromSize(
    //           size: Size.square(48),
    //           child: Stack(
    //             children: [
    //               Icon(
    //                 Icons.store,
    //                 color: Colors.brown,
    //                 size: 48,
    //               ),
    //               Text(
    //                 randNum,
    //                 style: TextStyle(fontSize: 18),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       //angle: pi / 3,
    //     );
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          IconButton(
              onPressed: () async {
                /// To Start assisted Selection
                await _mapController.advancedPositionPicker();

                /// To get location desired
                // GeoPoint p = await _mapController
                //     .getCurrentPositionAdvancedPositionPicker();

                /// To get location desired and close picker
                GeoPoint p =
                    await _mapController.selectAdvancedPositionPicker();

                _pickedLocation = LatLng(p.latitude, p.longitude);
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: OSMFlutter(
        controller: _mapController,
        isPicker: true,
        trackMyPosition: false,
        initZoom: 12,
        minZoomLevel: 2,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        // roadConfiguration: RoadConfiguration(
        //   startIcon: const MarkerIcon(
        //     icon: Icon(
        //       Icons.person,
        //       size: 64,
        //       color: Colors.brown,
        //     ),
        //   ),
        //   roadColor: Colors.yellowAccent,
        // ),
        // markerOption: MarkerOption(
        //     defaultMarker: const MarkerIcon(
        //   icon: Icon(
        //     Icons.person_pin_circle,
        //     color: Colors.blue,
        //     size: 56,
        //   ),
        // )),
      ),
    );
  }

  // @override
  // Future<void> mapIsReady(bool isReady) async {
  //   if (!isReady) {
  //     return;
  //   }
  //   await mapIsInitialized();
  // }
  //
  // Future<void> mapIsInitialized() async {
  //   await _mapController.setZoom(zoomLevel: 12);
  //   await _mapController.setMarkerOfStaticPoint(
  //     id: "line 2",
  //     markerIcon: MarkerIcon(
  //       icon: Icon(
  //         Icons.train,
  //         color: Colors.orange,
  //         size: 24,
  //       ),
  //     ),
  //   );
  //
  //   await _mapController.setStaticPosition(
  //     [
  //       GeoPointWithOrientation(
  //         latitude: 47.4433594,
  //         longitude: 8.4680184,
  //         angle: pi / 4,
  //       ),
  //       GeoPointWithOrientation(
  //         latitude: 47.4517782,
  //         longitude: 8.4716146,
  //         angle: pi / 2,
  //       ),
  //     ],
  //     "line 2",
  //   );
  //   final bounds = await _mapController.bounds;
  //   print(bounds.toString());
  //   Future.delayed(Duration(seconds: 5), () {
  //     _mapController.changeTileLayer(tileLayer: CustomTile.cycleOSM());
  //   });
  // }
}
