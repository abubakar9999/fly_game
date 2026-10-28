import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait for kid-friendly gameplay.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Hide the status bar for an immersive full-screen experience.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final storageService = StorageService();

  runApp(
    SpaceJourneyApp(
      storageService: storageService,
    ),
  );
}
