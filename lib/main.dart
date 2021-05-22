import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/home_screen.dart';
import 'package:planyapp/src/screens/login_screen.dart';
import 'package:planyapp/src/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PlanyApp',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('tr', 'TR'),
        ],
        home: _authService.hasCurrentUser ? HomeScreen() : LoginScreen());
  }
}
