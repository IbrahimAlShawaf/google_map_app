import 'package:flutter/material.dart';

import 'package:google_map_app/screens/welcome.dart';

// هذه الدالة تعتبر نقطة البدء الرئيسية لتطبيق Flutter. تقوم بتشغيل التطبيق وتهيئة العناصر الأساسية
void main() {
  runApp(MyApp());
}

// MyApp والذي يرث من StatelessWidget.هذا هو تعريف للعنصر
class MyApp extends StatelessWidget {
  // هذا هو بناء الكلاس MyApp
  // key. تم تحديدها كثابتة باستخدام الكلمة المفتاحية 'const'يأخذ معلمة اختيارية تسمى
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //اول صفحة
      home: Welcome(),
    );
  }
}
