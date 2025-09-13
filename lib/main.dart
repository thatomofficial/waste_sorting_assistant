import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:waste_sorting_assistant/presentation/screens/home/home_screen.dart';
import 'package:waste_sorting_assistant/presentation/theme/theme_data.dart';
import 'package:waste_sorting_assistant/presentation/routes/app_routes.dart';
import 'package:waste_sorting_assistant/core/constants/app_strings.dart';

// Import firebase options when available
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add providers here as they are implemented
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        // ChangeNotifierProvider(create: (_) => AuthProvider()),
        // ChangeNotifierProvider(create: (_) => WasteItemProvider()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppThemeData.lightTheme,
            darkTheme: AppThemeData.darkTheme,
            themeMode: themeNotifier.themeMode,
            initialRoute: AppRoutes.home,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}

// Temporary ThemeNotifier for the example
class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
