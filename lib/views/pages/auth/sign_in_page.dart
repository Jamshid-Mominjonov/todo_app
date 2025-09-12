import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/route/route_names.dart';
import '../../../view_models/auth/sign_in_view_model.dart';
import '../../../view_models/riverpod.dart';
import '../../widgets/auth/custom_button.dart';
import '../../widgets/auth/auth_text_field.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn({required String email, required String password}) {
    ref.read(signInNotifierProvider.notifier).signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInNotifierProvider);
    ref.listen(signInNotifierProvider, (previous, next) {
      if (next is SignInSuccess) {
        Navigator.pushReplacementNamed(context, RouteNames.dashboardPage);
      } else if (next is SignInError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.message)));
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
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.2),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Align(child: Image.asset('assets/images/phone2.png')),
                  SizedBox(height: screenHeight * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.03),
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
                  SizedBox(height: screenHeight * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: screenWidth * 0.03),
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
                  SizedBox(height: screenHeight * 0.01,),
                  GestureDetector(
                    onTap: (){},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff62D2C3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.17),
                  if (signInState is SignInError) Text(signInState.message),
                  signInState is SignInLoading
                   ? Center(child: CircularProgressIndicator.adaptive())
                   : CustomButton(
                    text: 'Login',
                    onPressed: () {
                      signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(width: 3),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.signUpPage);
                        },
                        child: Text(
                          'Sign Up',
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
