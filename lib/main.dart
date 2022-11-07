import 'package:chatty/app/chat_app.dart';
import 'package:chatty/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: FirebaseOptions(),
  );
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AuthNotifier();
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}
