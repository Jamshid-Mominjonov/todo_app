import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/route/route_names.dart';
import '../../../view_models/auth/sign_up_view_model.dart';
import '../../../view_models/riverpod.dart';
import '../../widgets/auth/custom_button.dart';
import '../../widgets/auth/auth_text_field.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void signUp({required String email, required String password, required String confirmPassword}) {
    ref.read(signUpNotifierProvider.notifier).signUp(email, password, confirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpNotifierProvider);
    ref.listen(signUpNotifierProvider, (previous, next) {
      if (next is SignUpSuccess) {
        Navigator.pushReplacementNamed(context, RouteNames.dashboardPage);
      } else if (next is SignUpError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message)));
      }
    });
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset('assets/images/shape.png'),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                top: screenHeight * 0.2,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Text(
                    'Create Account',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AuthTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AuthTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(
                          'Confirm password',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AuthTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm password',
                        obscureText: true,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.22),
                  if (signUpState is SignUpError) Text(signUpState.message),
                  signUpState is SignUpLoading
                   ? Center(child: CircularProgressIndicator())
                   : CustomButton(
                    text: 'Register',
                    onPressed: () {
                      signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim(),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(width: 3),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.signInPage);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xff62D2C3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
