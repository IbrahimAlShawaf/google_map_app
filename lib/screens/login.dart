import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_app/screens/homepage.dart';
import 'package:google_map_app/screens/register.dart';
import 'package:google_map_app/screens/welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // نعريف المتغيرات

  // إذا لم يتم إدخال أي قيمة، فإنه يُسمح بتخزين قيمة null. تم تعريفه كـ null-safety باستخدام العلامة ?.
  String? userEmail;
  String? userPassword;
  // يُستخدم عادة للتحقق من صحة المدخلات المدخلة من المستخدم وتنفيذ إجراءات محددة بناءً على ذلك
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // يُسهل استخدامه للوصول إلى القيمة المدخلة في الحقل وتحديثها أو استخدامها في وظائف أخرى
  TextEditingController emailTextController = TextEditingController();

  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //الرجوع للصفحة الترحيب
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return Welcome();
              }),
            );
          },
        ),
        title: Text(
          "Back To Welcome Screen",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.topLeft,
                      // مسار الصورة المتحركة
                      child: Image.asset('assets/images/login.gif'),
                    ),
                  ),
                  Text(
                    'Welcome back...',
                    style: GoogleFonts.actor(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 1),
                  ),
                  Text(
                    'Enter email & password',
                    style: GoogleFonts.actor(
                      fontWeight: FontWeight.w300,
                      color: Colors.black45,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // الايميل
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      }
                      // You can add email validation logic here
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // كلمة المرور
                  TextFormField(
                    controller: passwordTextController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userPassword = value ?? "";
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // You can perform registration logic here
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // زر الدخول
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.actor(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return RegisterScreen();
                              }),
                            );
                          },
                          child: const Text('Create Now!'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
