import 'dart:typed_data';
import 'package:aplos/resources/authentication_methods.dart';
import 'package:aplos/responsive/mobile_screen_layout.dart';
import 'package:aplos/responsive/web_screen_layout.dart';
import 'package:aplos/utils/constants.dart';
import 'package:flutter/material.dart';
import '../responsive/responsive_layout_screen.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  bool _isChecked = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _schoolController.dispose();
    _jobController.dispose();
    _bioController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String result = await AuthenticationMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      school: _schoolController.text,
      job: _jobController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ),
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No Image Selected');
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.white;
    }

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
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: selectImage,
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 90,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(
                                  "https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg"),
                            ),
                      Positioned(
                        bottom: -10,
                        right: -8,
                        child: IconButton(
                          iconSize: 40,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                TextFieldInput(
                  hintText: "Username",
                  textInputType: TextInputType.name,
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                  textEditingController: _usernameController,
                ),
                const SizedBox(height: 15),
                TextFieldInput(
                  hintText: "Email",
                  textInputType: TextInputType.name,
                  icon: const Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 40,
                  ),
                  textEditingController: _emailController,
                ),
                const SizedBox(height: 15),
                TextFieldInput(
                  hintText: "Password",
                  textInputType: TextInputType.name,
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 40,
                  ),
                  textEditingController: _passwordController,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Divider(
                    color: secondaryColor,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldInput(
                      fontSize: 20,
                      width: 190,
                      height: 61,
                      hintText: "School",
                      textInputType: TextInputType.name,
                      icon: const Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 30,
                      ),
                      textEditingController: _schoolController,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextFieldInput(
                      fontSize: 20,
                      width: 190,
                      height: 61,
                      hintText: "Job Title",
                      textInputType: TextInputType.name,
                      icon: const Icon(
                        Icons.rocket_launch,
                        color: Colors.white,
                        size: 30,
                      ),
                      textEditingController: _jobController,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 382,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(
                      fontSize: 24,
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                    controller: _bioController,
                    decoration: InputDecoration(
                      fillColor: secondaryColor,
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                      hintText: "  Tell us a bit about yourself...",
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: secondaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: secondaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: secondaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      contentPadding:
                          const EdgeInsets.only(bottom: 40, top: 10, left: 5),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Checkbox(
                      overlayColor: MaterialStateProperty.resolveWith(getColor),
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const Text("I read and agree to the ",
                        style: TextStyle(color: whiteColor)),
                    const Text(
                      "Terms and Conditions",
                      style: TextStyle(color: Colors.lightBlue),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    signUpUser();
                  },
                  child: Container(
                    height: 70,
                    width: 360,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: whiteColor),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Already have an account? ",
                          style: TextStyle(color: whiteColor)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Login.",
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
