import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'connextion.dart';
import 'twitter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final goRouter = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ConnexionPage(),
        ),
        GoRoute(
          path: '/twitter',
          builder: (context, state) =>
              const TwitterPage(),
        ),
      ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Mod 8 demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}