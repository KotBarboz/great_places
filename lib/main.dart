import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/shelf.dart';

import '../providers/great_places.dart';
import '../screens/add_place_screen.dart';
import '../screens/places_list_screen.dart';
// import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  // var handler =
  //     const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
  // final port = int.parse(Platform.environment['PORT'] ?? '8080');
  // var server = await shelf_io.serve(handler, 'localhost', port);
  //
  // // Enable content compression
  // server.autoCompress = true;
  //
  // print('Serving at http://${server.address.host}:${server.port}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}

Response _echoRequest(Request request) =>
    Response.ok('Request for "${request.url}"');
