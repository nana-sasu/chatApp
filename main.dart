import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messageapp/services/auth/auth_gate.dart';
//import 'package:messageapp/auth/login_or_register.dart';
//import 'package:messageapp/themes/light_mode.dart';
import 'package:messageapp/firebase_options.dart';
import 'package:messageapp/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: "AIzaSyAR1iqVXIw2O1USH7LBgzPN4Y22GnDlwhw",
  //           authDomain: "messageapp-ec791.firebaseapp.com",
  //           projectId: "messageapp-ec791",
  //           storageBucket: "messageapp-ec791.appspot.com",
  //           messagingSenderId: "264386057956",
  //           appId: "1:264386057956:web:fb9970ff981502e4357ef1"));
  // } else {
  //   await Firebase.initializeApp();
  // }

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
