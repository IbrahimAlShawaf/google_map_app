import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_map_app/screens/dataPreview.dart';
import 'package:google_map_app/screens/map.dart';


class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  //  geocodingداخل ملف يامل  يجب تثبيت حزمة     placemarkFromCoordinatesللوصول الى الدالة
  getData() async{
    List<Placemark> placemarks =
    await placemarkFromCoordinates(31.317600, 34.339093);

  }
  @override
  void initState() {
    getData();
    super.initState();
   }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              height: 500,
              child: ListView.builder(
                   itemCount: lngNew.length,
                  itemBuilder: (context ,index){
                  return Column(
                    children: [
                      Row(
                        children: [const Text('title :'), Text('${titles[index]}')],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [const Text('latitude :'), Text('${latNew[index]}')],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [const Text('longitude :'), Text('${lngNew[index]}')],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [const Text('distance :'), Text('${distance[index].toStringAsFixed(2)} Km')],
                      ),
                      const SizedBox(height: 20,),
                    Row(
                    children: [
                    if (distance[index] <= 1)
                    const Text('Data storage (distance less than 1 km):'),
                    if (distance[index] > 1)
                    const Text('Data storage (distance greater than 1 km):'),
                    Text('${distance[index].toStringAsFixed(2)} ')
                    ],
                                   ),
                      const SizedBox(height: 30,),
                      const Divider(height: 5,color: Colors.blue),
                      const SizedBox(height: 30,),

                    ],
                  );
              }),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const DataPreview();
                }));
              },
              child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                height: 50,
                width: 150,
                child: const Text('data preview',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
