// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/sensor_provider.dart';
import 'providers/storage_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/detail_sensor_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize storage provider
  final storageProvider = StorageProvider();
  await storageProvider.initializeStorage();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StorageProvider()..initializeStorage()),
        ChangeNotifierProvider(create: (_) => SensorProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Room Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0066FF),
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF0052CC),
          foregroundColor: Colors.white,
          scrolledUnderElevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0052CC),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFF0052CC),
          foregroundColor: Colors.white,
          elevation: 6,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.black.withOpacity(0.1),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/detail': (context) {
          final sensorId = ModalRoute.of(context)?.settings.arguments as String;
          return DetailSensorScreen(sensorId: sensorId);
        },
      },
    );
  }
}
