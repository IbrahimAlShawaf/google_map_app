import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // تعريف الـ العلامة
  var myMarkers = HashSet<Marker>(); //collection

// لوضع صورة مصغرة على الموقع بدلا من الصورة الإفتراضية
  late BitmapDescriptor customMarker; //attribute
  getCustomMarker() async {
    customMarker = BitmapDescriptor.defaultMarker;

    // بإمكانك إضافة صورة افتراضية بدلا من العلامة
    // await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration.empty,
    //     'assets/images/cc2s.png'); // حجم الصورة يكون صغير 60*60 بكسل
  }

  @override
  void initState() {
    super.initState();
    // تنفيذ الصورة
    getCustomMarker();
    // تنفيذ المضلع
    myPolygon.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: polygonCoords,
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.transparent,
        geodesic: true,
      ),
    );
  }

// تعريف المضلع تحديد الاتجاهات الأربعة
  Set<Polygon> myPolygon = HashSet<Polygon>();
  List<LatLng> polygonCoords = const [
    LatLng(31.317686731889115,
        34.339115355764045), //31.317688658724915, 34.339116483494045
    LatLng(31.317602914493357, 34.339213468274934),
    LatLng(31.31752295070144, 34.33911873895407),
    LatLng(31.317607731587078, 34.33901949871317),
  ];

  // Add Polyline
  static Polyline kPolyline = const Polyline(
      polylineId: PolylineId('kPolyline'),
      points: [
        LatLng(31.317604841330883, 34.33911873895407),
        LatLng(31.321944565361267, 34.34206938913718),
      ],
      width: 3,
      color: Colors.red);

  late GoogleMapController mapController;

  LatLng? _selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Map',
          style: GoogleFonts.actor(
              fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1),
        ),
      ),
      body: Column(children: [
        // تحديد النقطة الرئيسية المحددة على الخريطة
        Expanded(
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(31.317604841330883, 34.33911873895407),
              zoom: 18, //31.323858294005436, 34.345570029656535
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                mapController = googleMapController;
                // إضافة العلامة وتغيير الاسم عليها
                myMarkers.add(
                  Marker(
                    markerId: const MarkerId('1'),
                    position:
                        const LatLng(31.317604841330883, 34.33911873895407),
                    infoWindow: InfoWindow(
                      title: 'My Home',
                      snippet: 'Ahmed Anwar Al Shawwaf',
                      onTap: () {
                        print('Marker tabed'); // add your url location >>>>>
                      },
                    ),
                    // تنفيذ الصورة المضافة في خانة الأيكون
                    icon: customMarker,
                  ),
                );
              });
            },
            onTap: (position) {
              setState(() {
                myMarkers.add(
                  Marker(
                    markerId: MarkerId(position.toString()),
                    position: position,
                  ),
                );
                _selectedPosition = position;
              });
            },
            // إضافة العلامات والمضلع
            markers: myMarkers,
            polygons: myPolygon,
            polylines: {
              kPolyline,
            },
          ),
        ),

        // تحديد الصورة الجانبية
        // Container(
        //   height: 60,
        //   width: 60,
        //   alignment: Alignment.topLeft,
        //   child: Image.asset('assets/images/c2s.jpg'),
        // ),
        // تحديد الاسم
        // Container(
        //   alignment: Alignment.bottomCenter,
        //   child: const Text(
        //     'Ahmed Anwar Al Shawwaf',
        //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        //   ),
        // )
      ]),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        elevation: 10.0,
        onPressed: () {
          if (_selectedPosition != null) {
            Navigator.pushNamed(
              context,
              '/data',
              arguments: _selectedPosition,
            );
          }
        },
        child: Icon(
          Icons.map,
          size: 35,
        ),
      ),
    );
  }
}
