import 'dart:io';

import 'package:nlu_portal_app/app.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/utils/http_config.dart';
import 'package:nlu_portal_app/providers/auth_provider.dart';
import 'package:nlu_portal_app/providers/semester_provider.dart';
import 'package:nlu_portal_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // 🔥 SSL bypass (DEV ONLY)
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.tryAutoLogin();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => UserProvider()..getUserInfo()),
        ChangeNotifierProvider(create: (_) => SemesterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NLU Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          surfaceTintColor: AppColors.primary,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
