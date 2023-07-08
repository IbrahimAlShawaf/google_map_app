import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
// عمل أنيميشن لدخول التطبيق تحنوي صورة متحركة وإسم التطبيق
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        // التحويل الى صفحة الدخول بعد 4 ثواني
        Navigator.pushReplacementNamed(context, '/login');
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.topLeft,
                  // مسار الصورة
                  child: Image.asset('assets/images/worldwide.gif'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // الترحيب بالزائر
              Text(
                'Welcome Back',
                style: GoogleFonts.actor(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1),
              ),
              Text(
                'To My Google Maps',
                style: GoogleFonts.actor(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
