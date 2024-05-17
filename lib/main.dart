import 'package:flutter/material.dart';
// import 'package:intelligentsia1/firebase_options.dart';
// import 'package:intelligentsia1/quizapp.dart/categories.dart';
// import 'package:intelligentsia1/quizapp.dart/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intt/firebase_options.dart';
import 'package:intt/spl.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
