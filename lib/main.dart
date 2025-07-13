import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcard/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: HomePage.routeName,
        name: HomePage.routeName,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
