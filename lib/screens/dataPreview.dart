

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map_app/screens/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataPreview extends StatefulWidget {
  const DataPreview({super.key});

  @override
  State<DataPreview> createState() => _DataPreviewState();
}

class _DataPreviewState extends State<DataPreview> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(latNew[latNew.length-1], lngNew[lngNew.length-1]),
    zoom: 11.4746,
  );
  Set<Marker> markers ={
    Marker(markerId:const MarkerId('1'),position:LatLng(latNew[latNew.length-1], lngNew[lngNew.length-1]),
          // قائمة اخر قيمة في قائمةlang and lat lngNew.length-1
        infoWindow: InfoWindow(title: titles[titles.length-1])),

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Preview'),
      ),
      body: Column(
        children: [
          Container(
            height: 700,

            width: double.infinity,
            child: GoogleMap(
              markers: markers,
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }
}
