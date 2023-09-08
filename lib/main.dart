import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/firebase_options.dart';
import 'package:flutter_application_pw17/screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    FirebaseFirestore.instance
        .useFirestoreEmulator('127.0.0.1', 8080, sslEnabled: false);

    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
    await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);

    await FirebaseStorage.instance.useStorageEmulator(
      'localhost',
      9199,
    );
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
          helperStyle: TextStyle(
            background: Paint()
              ..color = Colors.blue
              ..strokeWidth = 13
              ..strokeJoin = StrokeJoin.round
              ..strokeCap = StrokeCap.round
              ..style = PaintingStyle.stroke,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: Colors.lightBlue,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
