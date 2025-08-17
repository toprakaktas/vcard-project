import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/pages/form_page.dart';
import 'package:vcard/pages/home_page.dart';
import 'package:vcard/pages/scan_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'VCard Project',
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
        routes: <RouteBase>[
          GoRoute(
            path: ScanPage.routeName,
            name: ScanPage.routeName,
            builder: (context, state) => const ScanPage(),
            routes: <RouteBase>[
              GoRoute(
                path: FormPage.routeName,
                name: FormPage.routeName,
                builder:
                    (context, state) =>
                        FormPage(contactModel: state.extra! as ContactModel),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
