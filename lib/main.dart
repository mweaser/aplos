import 'package:aplos/providers/user_provider.dart';
import 'package:aplos/responsive/mobile_screen_layout.dart';
import 'package:aplos/responsive/responsive_layout_screen.dart';
import 'package:aplos/responsive/web_screen_layout.dart';
import 'package:aplos/screens/login_screen.dart';
import 'package:aplos/screens/sign_up_screen.dart';
import 'package:aplos/screens/welcome_screen.dart';
import 'package:aplos/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDQKnaPK_uRRBVFKoh2QXmBj16Hre_R5JQ",
        appId: "1:75835678851:ios:82035bc922e139d3b5bbb6",
        messagingSenderId: "75835678851",
        projectId: "aplos-1b045",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: "aplos",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout());
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const WelcomeScreen();
          },
        ),
      ),
    );
  }
}
