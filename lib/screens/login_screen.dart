import 'package:aplos/resources/authentication_methods.dart';
import 'package:aplos/responsive/mobile_screen_layout.dart';
import 'package:aplos/responsive/responsive_layout_screen.dart';
import 'package:aplos/responsive/web_screen_layout.dart';
import 'package:aplos/screens/sign_up_screen.dart';
import 'package:aplos/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String result = await AuthenticationMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (result == "success") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF383737),
        title: const Text(
          "aplós",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 35, color: primaryColor),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.1,
              0.3,
              0.7,
            ],
            colors: [
              Color(0xFF383737),
              Color(0xFF282727),
              Color(0xFF151515),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  width: 248,
                  height: 200,
                  child: Image.asset("assets/logo.png"),
                ),
                const SizedBox(height: 15),
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  icon: const Icon(Icons.email, size: 40),
                  height: 71,
                ),
                const SizedBox(height: 25),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: "Password",
                  textInputType: TextInputType.visiblePassword,
                  icon: const Icon(Icons.lock, size: 40),
                  height: 71,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(right: 25),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Forgot your password?",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 70,
                    width: 360,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: whiteColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 10),
                        child: const Divider(
                          thickness: 1,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                          color: secondaryColor, fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 20),
                        child: const Divider(
                          thickness: 1,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Continue with",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 64,
                        width: 64,
                        child: Image.asset('assets/google.png'),
                      ),
                    ),
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 64,
                        width: 64,
                        child: Image.asset('assets/facebook.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          " Sign up",
                          style: TextStyle(color: Colors.lightBlue),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
