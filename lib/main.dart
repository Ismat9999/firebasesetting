import 'package:firebase_core/firebase_core.dart';
import 'package:firesetting/pages/home_page.dart';
import 'package:firesetting/pages/signin_page.dart';
import 'package:firesetting/pages/signup_page.dart';
import 'package:firesetting/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCmgPMNF0FEDd5RJxI-hJHoj4Qz5ZKKbXU',
      appId: '1:280526705110:android:31bde3df826c0aa4af1477',
      messagingSenderId: '280526705110',
      projectId: 'fire1-6eb1f',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.id: (context) => const SplashPage(),
        HomePage.id: (context) => const HomePage(),
        SigninPage.id: (context) => const SigninPage(),
        SignupPage.id: (context) => const SignupPage(),
      },
    );
  }
}

