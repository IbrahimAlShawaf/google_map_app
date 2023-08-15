import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_app/screens/data.dart';
import 'package:google_map_app/screens/homepage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<double> distance = [];
List<double> latNew = [];
List<double> lngNew = [];
List<String> titles = [];
List<String> images = [];
int i = 3;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
//   الذي
//   (غير قابل لإعادة التعيين final )
  final Completer<GoogleMapController> _controller =
//  يتم استخدام Completer للسماح بالوصول إلى مرجع GoogleMapController
      Completer<GoogleMapController>();
  TextEditingController image = TextEditingController();
  TextEditingController title = TextEditingController();

  // المستخدم لتعريف موقع الكاميرا على الخريطة. يحتوي CameraPosition
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat!, lng!),
    zoom: 11.74,
  );

  Set<Marker> markers = {
    Marker(
        markerId: const MarkerId('1'),
        position: LatLng(lat!, lng!),
        infoWindow: const InfoWindow(title: 'my Location')),
  };
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              (lat == null)
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: 500,
                      width: double.infinity,
                      child: GoogleMap(
                        markers: markers,
                        onTap: (latLng) async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Enter info of location'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      TextFormField(
                                        controller: title,
                                        decoration: const InputDecoration(
                                          label: Text('title'),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: image,
                                        decoration: const InputDecoration(
                                          label: Text('image'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          markers.add(Marker(
                                            markerId: MarkerId('${i + 1}'),
                                            position: LatLng(latLng.latitude,
                                                latLng.longitude),
                                            infoWindow:
                                                InfoWindow(title: title.text),
                                            icon: await BitmapDescriptor
                                                .fromAssetImage(
                                              const ImageConfiguration(
                                                size: Size(10, 24),
                                              ),
                                              'images/${image.text}.png',
                                            ),
                                            //draggable يمكن سحب الماركر وتغيير موقعه
                                            draggable: true,
                                          ));
                                          latNew.add(latLng.latitude);
                                          lngNew.add(latLng.longitude);
                                          titles.add(title.text);
                                          setState(() {
                                            title.clear();
                                            image.clear();
                                          });

                                          Navigator.of(context).pop();
                                        },
                                        child: Text('yes')),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          //pop سيتم إغلاق الـ AlertDialog
                                        },
                                        child: Text('no')),
                                  ],
                                );
                              });

                          distance.add(
                              //محدد الموقع الجغرافي Geolocator
                              await Geolocator.distanceBetween(lat!, lng!,
                                      latLng.latitude, latLng.longitude) /
                                  1000);
                          setState(() {});
                          i++;
                        },
                        mapType: MapType.satellite,
                        //hالتحكم في الخريطة كتنقل وتحكم
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DataPage();
                  }));
                },
                child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  height: 50,
                  width: 150,
                  child: const Text('data page',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   // تعريف الـ العلامة
//   var myMarkers = HashSet<Marker>(); //collection

// // لوضع صورة مصغرة على الموقع بدلا من الصورة الإفتراضية
//   late BitmapDescriptor customMarker; //attribute
//   getCustomMarker() async {
//     customMarker = BitmapDescriptor.defaultMarker;

//     // بإمكانك إضافة صورة افتراضية بدلا من العلامة
//     // await BitmapDescriptor.fromAssetImage(
//     //     ImageConfiguration.empty,
//     //     'assets/images/cc2s.png'); // حجم الصورة يكون صغير 60*60 بكسل
//   }

//   @override
//   void initState() {
//     super.initState();
//     // تنفيذ الصورة
//     getCustomMarker();
//     // تنفيذ المضلع
//     myPolygon.add(
//       Polygon(
//         polygonId: const PolygonId('1'),
//         points: polygonCoords,
//         strokeWidth: 2,
//         strokeColor: Colors.red,
//         fillColor: Colors.transparent,
//         geodesic: true,
//       ),
//     );
//   }

// // تعريف المضلع تحديد الاتجاهات الأربعة
//   Set<Polygon> myPolygon = HashSet<Polygon>();
//   List<LatLng> polygonCoords = const [
//     LatLng(31.317686731889115,
//         34.339115355764045), //31.317688658724915, 34.339116483494045
//     LatLng(31.317602914493357, 34.339213468274934),
//     LatLng(31.31752295070144, 34.33911873895407),
//     LatLng(31.317607731587078, 34.33901949871317),
//   ];

//   // Add Polyline
//   static Polyline kPolyline = const Polyline(
//       polylineId: PolylineId('kPolyline'),
//       points: [
//         LatLng(31.317604841330883, 34.33911873895407),
//         LatLng(31.321944565361267, 34.34206938913718),
//       ],
//       width: 3,
//       color: Colors.red);

//   late GoogleMapController mapController;

//   LatLng? selectedPosition;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey,
//         title: Text(
//           'Map',
//           style: GoogleFonts.actor(
//               fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1),
//         ),
//       ),
//       body: Column(children: [
//         // تحديد النقطة الرئيسية المحددة على الخريطة
//         Expanded(
//           child: GoogleMap(
//             initialCameraPosition: const CameraPosition(
//               target: LatLng(31.317604841330883, 34.33911873895407),
//               zoom: 18, //31.323858294005436, 34.345570029656535
//             ),
//             onMapCreated: (GoogleMapController googleMapController) {
//               setState(() {
//                 mapController = googleMapController;
//                 // إضافة العلامة وتغيير الاسم عليها
//                 myMarkers.add(
//                   Marker(
//                     markerId: const MarkerId('1'),
//                     position:
//                         const LatLng(31.317604841330883, 34.33911873895407),
//                     infoWindow: InfoWindow(
//                       title: 'My Home',
//                       snippet: 'Ahmed Anwar Al Shawwaf',
//                       onTap: () {
//                         print('Marker tabed'); // add your url location >>>>>
//                       },
//                     ),
//                     // تنفيذ الصورة المضافة في خانة الأيكون
//                     icon: customMarker,
//                   ),
//                 );
//               });
//             },
//             onTap: (position) {
//               setState(() {
//                 myMarkers.add(
//                   Marker(
//                     markerId: MarkerId(position.toString()),
//                     position: position,
//                   ),
//                 );
//                 selectedPosition = position;
//               });
//             },
//             // إضافة العلامات والمضلع
//             markers: myMarkers,
//             polygons: myPolygon,
//             polylines: {
//               kPolyline,
//             },
//           ),
//         ),

//         // تحديد الصورة الجانبية
//         // Container(
//         //   height: 60,
//         //   width: 60,
//         //   alignment: Alignment.topLeft,
//         //   child: Image.asset('assets/images/c2s.jpg'),
//         // ),
//         // تحديد الاسم
//         // Container(
//         //   alignment: Alignment.bottomCenter,
//         //   child: const Text(
//         //     'Ahmed Anwar Al Shawwaf',
//         //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         //   ),
//         // )
//       ]),
      
//     );
//   }
// }
