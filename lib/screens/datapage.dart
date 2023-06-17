import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  late LatLng selectedPoint;
  double distance = 0.0;
  List<DataPoint> dataPoints = [];

  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  void calculateDistance() {
    if (selectedPoint != null) {
      final double earthRadius = 6371000; // in meters
      final double lat1 = selectedPoint.latitude;
      final double lon1 = selectedPoint.longitude;
      final double lat2 = myLocation.latitude;
      final double lon2 = myLocation.longitude;

      final double dLat = _toRadians(lat2 - lat1);
      final double dLon = _toRadians(lon2 - lon1);

      final double a = sin(dLat / 2) * sin(dLat / 2) +
          cos(_toRadians(lat1)) *
              cos(_toRadians(lat2)) *
              sin(dLon / 2) *
              sin(dLon / 2);
      final double c = 2 * asin(sqrt(a));

      distance = earthRadius * c;
    } else {
      distance = 0.0;
    }
  }

  double _toRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void addDataPoint() {
    if (distance <= 100) {
      final double latitude = double.parse(latitudeController.text);
      final double longitude = double.parse(longitudeController.text);

      setState(() {
        dataPoints.add(DataPoint(latitude, longitude));
      });
    }

    latitudeController.clear();
    longitudeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Add Data Page',
          style: GoogleFonts.actor(
              fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Latitude:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: latitudeController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text(
              'Longitude:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: longitudeController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final double latitude = double.parse(latitudeController.text);
                  final double longitude =
                      double.parse(longitudeController.text);
                  selectedPoint = LatLng(latitude, longitude);
                  calculateDistance();
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Calculate Distance',
                style: GoogleFonts.actor(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Distance to selected point: ${distance.toStringAsFixed(2)} meters',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addDataPoint,
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Add Data Point',
                style: GoogleFonts.actor(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewDataPage extends StatelessWidget {
  final LatLng point;

  PreviewDataPage({required this.point});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Data Page'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: point,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('selectedPoint'),
            position: point,
          ),
        },
      ),
    );
  }
}

class DataPoint {
  final double latitude;
  final double longitude;

  DataPoint(this.latitude, this.longitude);
}

final LatLng myLocation =
    LatLng(37.7749, -122.4194); // Replace with your actual location