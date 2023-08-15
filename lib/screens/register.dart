import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_app/screens/homepage.dart';
import 'package:google_map_app/screens/login.dart';
import 'package:google_map_app/screens/welcome.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // نعريف المتغيرات

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? userName, userEmail, userPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                      child: Image.asset('assets/images/registered.gif'),
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
                    'Enter Your Information',
                    style: GoogleFonts.actor(
                      fontWeight: FontWeight.w300,
                      color: Colors.black45,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 40),
// إسم المستخدم
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'UserName',
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
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userName = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  // الايميل

                  TextFormField(
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
                    onSaved: (value) {
                      userEmail = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  // كلمة المرور

                  TextFormField(
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
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userPassword = value!;
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
                        }));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'ٌRegister',
                      style: GoogleFonts.actor(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('have an account'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          },
                          child: const Text('Login Now!'))
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
