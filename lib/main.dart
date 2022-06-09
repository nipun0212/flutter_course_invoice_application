// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

const bool useEmulator = false;
const bool usePhysicalDevice = false;
const bool useWeb = false;

const String ipAddress = "192.168.1.2";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (useEmulator) {
    if (usePhysicalDevice) {
      String host = defaultTargetPlatform == TargetPlatform.android
          ? '$ipAddress:8080'
          : 'localhost:8080';
      FirebaseFirestore.instance.settings =
          Settings(host: host, sslEnabled: false);
      FirebaseFirestore.instance.useFirestoreEmulator(host.split(':')[0], 8080);
      await FirebaseAuth.instance.useAuthEmulator(host.split(':')[0], 9099);
    } else {
      String host = defaultTargetPlatform == TargetPlatform.android
          ? '10.0.2.2:8080'
          : 'localhost:8080';
      if (useWeb) {
        FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
      } else {
        FirebaseFirestore.instance.settings =
            Settings(host: host, sslEnabled: false);
      }
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }
  }
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ElevatedButton(
                child: Text("Sign In"),
                onPressed: () async {
                  String? uid =
                      (await FirebaseAuth.instance.signInAnonymously())
                          .user
                          ?.uid;
                  FirebaseFirestore.instance
                      .collection('users')
                      .add({"uid": uid});
                }),
            ElevatedButton(
                child: Text("Sign Out"),
                onPressed: () async => await FirebaseAuth.instance.signOut()),
          ],
        ),
      ),
    );
  }
}
