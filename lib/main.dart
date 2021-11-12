import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frsc_presentation/core/services/auth.dart';
import 'package:provider/provider.dart';

import 'screens/get_started.dart';
import 'screens/home/homescreen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends MaterialApp {
  MyApp({
    Key? key,
  }) : super(
            key: key,
            debugShowCheckedModeBanner: false,
            initialRoute: '/get-started',
            routes: {
              '/get-started': (context) => const GetStarted(),
            });

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    if (user != null) {
      return HomeScreen();
    }
    return GetStarted();
  }
}
