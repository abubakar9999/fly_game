import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../ui/home_screen.dart';

/// Root MaterialApp widget for Space Journey.
class SpaceJourneyApp extends StatelessWidget {
  final StorageService storageService;

  const SpaceJourneyApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space Journey',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0E14),
        fontFamily: 'sans-serif',
      ),
      home: HomeScreen(storageService: storageService),
    );
  }
}

