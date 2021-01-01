import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart' deferred as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp defaultApp = await Firebase.initializeApp();
  print('Check FirebaseApp => ${defaultApp.toString()}');

  final Future<void> loadedLibrary = await app.loadLibrary();

  runApp(
    FutureBuilder(
      future: loadedLibrary,
      builder: (snapshot, context) => app.FriendlyEatsApp(),
    ),
  );
}
