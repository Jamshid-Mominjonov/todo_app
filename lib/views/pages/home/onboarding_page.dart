import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/route/route_names.dart';
import '../../widgets/auth/custom_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  Future<void> checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if(!mounted) return;

    if(user != null) {
      Navigator.pushReplacementNamed(context, RouteNames.dashboardPage);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.signUpPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Stack(
        children: [
          Positioned(child: Image.asset('assets/images/shape.png'),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.04, right: screenWidth * 0.04, top: screenHeight * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.15),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/phone.png')
                ),
                SizedBox(height: screenHeight * 0.2),
                Text(
                    'Get things done with TODO',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.26),
                CustomButton(text: 'Get Started', onPressed: (){checkUser();}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}