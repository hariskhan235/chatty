import 'package:chatty/utils/route_names.dart';
import 'package:chatty/utils/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
