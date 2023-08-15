import 'package:flutter/material.dart';
import 'package:google_map_app/screens/login.dart';
import 'package:google_map_app/screens/register.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 80,
                    backgroundImage: AssetImage("assets/images/palestine.png"),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "My Google Maps",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {
                      //التنقل بين الصفحاتNavigator
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }),
                      );
                    },
                    //infinity ما لا نهاية حجم الزر لكل الصفحة
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(color: Colors.indigo),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }),
                      );
                    },
                    color: Colors.indigoAccent,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(color: Colors.indigo),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
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








// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_map_app/screens/login.dart';

// class WelcomeScreen extends StatefulWidget {
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }
// // عمل أنيميشن لدخول التطبيق تحنوي صورة متحركة وإسم التطبيق
// class _WelcomeScreenState extends State<WelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeIn,
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(
//       const Duration(seconds: 4),
//       () {
//         // التحويل الى صفحة الدخول بعد 4 ثواني
//        //التنقل بين الصفحاتNavigator
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) {
//                           return LoginScreen();
//                         }),
//                       );
//       },
//     );
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: FadeTransition(
//           opacity: _animation,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   height: 200,
//                   width: 200,
//                   alignment: Alignment.topLeft,
//                   // مسار الصورة
//                   child: Image.asset('assets/images/worldwide.gif'),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               // الترحيب بالزائر
//               Text(
//                 'Welcome Back',
//                 style: GoogleFonts.actor(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                     letterSpacing: 1),
//               ),
//               Text(
//                 'To My Google Maps',
//                 style: GoogleFonts.actor(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                     letterSpacing: 1),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
