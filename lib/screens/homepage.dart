import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_app/screens/login.dart';
import 'package:google_map_app/screens/map.dart';


double? lat ;
double? lng ;
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //  يُستخدم Future لتعريف دالة مُستدعاة تعمل بشكل غير متزامن وتُرجع قيمة في وقت لاحق
  Future getPosition() async{
    // bool services;: تعريف متغير من نوع Boolean لتخزين حالة خدمة الموقع
    bool services ;
 // تعريف متغير من نوع LocationPermission لتخزين حالة إذن الوصول إلى الموقع.
    LocationPermission locationPermission;

    services = await Geolocator.isLocationServiceEnabled();

    if(services == false){

    // إذا كانت خدمة الموقع معطلة، يمكنك إضافة رمز هنا لاتخاذ إجراءات إضافية، مثل طلب تشغيل خدمة الموقع من المستخدم
    }

    locationPermission = await Geolocator.checkPermission();

    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
      setState(() {

      });
    }
  }

   getLatAndLng() async{

   await Geolocator.getCurrentPosition().then((value) {
            setState(() {

              lat = value.latitude;
              lng = value.longitude;
              print(lat);
              print(lng);
      });
    });

  }


  @override
  void initState() {
   getPosition();
   getLatAndLng();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Home Page',
          style: GoogleFonts.actor(
              fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // زر الدحول الى الخريطة
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push (MaterialPageRoute(builder: (context) {
                  return MapPage();
                }));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Map Page Collection',
                style: GoogleFonts.actor(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1),
              ),
            ),
            
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // زر الخروج من التطبيق
              child: Text(
                'Logout',
                style: GoogleFonts.actor(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
