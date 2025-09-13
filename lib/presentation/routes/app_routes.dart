import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
// Import screens as they are implemented
// import '../screens/auth/login_screen.dart';
// import '../screens/auth/register_screen.dart';
// import '../screens/auth/forgot_password_screen.dart';
// import '../screens/scan/scan_screen.dart';
// import '../screens/profile/profile_screen.dart';
// import '../screens/history/history_screen.dart';
// import '../screens/settings/settings_screen.dart';
// import '../screens/onboarding/onboarding_screen.dart';
// import '../screens/splash/splash_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String scan = '/scan';
  static const String scanResult = '/scan-result';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String history = '/history';
  static const String historyDetail = '/history-detail';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String help = '/help';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
  static const String notifications = '/notifications';
  static const String theme = '/theme';
  static const String language = '/language';
  static const String wasteCategories = '/waste-categories';
  static const String wasteCategoryDetail = '/waste-category-detail';
  static const String tips = '/tips';
  static const String statistics = '/statistics';
  static const String achievements = '/achievements';
  static const String leaderboard = '/leaderboard';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(
          // const SplashScreen(),
          const Placeholder(child: Text('Splash Screen')),
          settings,
        );

      case onboarding:
        return _buildRoute(
          // const OnboardingScreen(),
          const Placeholder(child: Text('Onboarding Screen')),
          settings,
        );

      case login:
        return _buildRoute(
          // const LoginScreen(),
          const Placeholder(child: Text('Login Screen')),
          settings,
        );

      case register:
        return _buildRoute(
          // const RegisterScreen(),
          const Placeholder(child: Text('Register Screen')),
          settings,
        );

      case forgotPassword:
        return _buildRoute(
          // const ForgotPasswordScreen(),
          const Placeholder(child: Text('Forgot Password Screen')),
          settings,
        );

      case home:
        return _buildRoute(
          const HomeScreen(),
          settings,
        );

      case scan:
        return _buildRoute(
          // const ScanScreen(),
          const Placeholder(child: Text('Scan Screen')),
          settings,
        );

      case scanResult:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          // ScanResultScreen(
          //   imagePath: args?['imagePath'] ?? '',
          //   results: args?['results'] ?? [],
          // ),
          Placeholder(
            child: Text('Scan Result Screen\n${args?.toString() ?? "No args"}'),
          ),
          settings,
        );

      case profile:
        return _buildRoute(
          // const ProfileScreen(),
          const Placeholder(child: Text('Profile Screen')),
          settings,
        );

      case editProfile:
        return _buildRoute(
          // const EditProfileScreen(),
          const Placeholder(child: Text('Edit Profile Screen')),
          settings,
        );

      case history:
        return _buildRoute(
          // const HistoryScreen(),
          const Placeholder(child: Text('History Screen')),
          settings,
        );

      case historyDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          // HistoryDetailScreen(
          //   historyItem: args?['historyItem'],
          // ),
          Placeholder(
            child: Text('History Detail Screen\n${args?.toString() ?? "No args"}'),
          ),
          settings,
        );

      case AppRoutes.settings:
        return _buildRoute(
          // const SettingsScreen(),
          const Placeholder(child: Text('Settings Screen')),
          settings,
        );

      case about:
        return _buildRoute(
          // const AboutScreen(),
          const Placeholder(child: Text('About Screen')),
          settings,
        );

      case help:
        return _buildRoute(
          // const HelpScreen(),
          const Placeholder(child: Text('Help Screen')),
          settings,
        );

      case privacy:
        return _buildRoute(
          // const PrivacyScreen(),
          const Placeholder(child: Text('Privacy Screen')),
          settings,
        );

      case terms:
        return _buildRoute(
          // const TermsScreen(),
          const Placeholder(child: Text('Terms Screen')),
          settings,
        );

      case notifications:
        return _buildRoute(
          // const NotificationsScreen(),
          const Placeholder(child: Text('Notifications Screen')),
          settings,
        );

      case theme:
        return _buildRoute(
          // const ThemeScreen(),
          const Placeholder(child: Text('Theme Screen')),
          settings,
        );

      case language:
        return _buildRoute(
          // const LanguageScreen(),
          const Placeholder(child: Text('Language Screen')),
          settings,
        );

      case wasteCategories:
        return _buildRoute(
          // const WasteCategoriesScreen(),
          const Placeholder(child: Text('Waste Categories Screen')),
          settings,
        );

      case wasteCategoryDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          // WasteCategoryDetailScreen(
          //   category: args?['category'] ?? '',
          // ),
          Placeholder(
            child: Text('Waste Category Detail Screen\n${args?.toString() ?? "No args"}'),
          ),
          settings,
        );

      case tips:
        return _buildRoute(
          // const TipsScreen(),
          const Placeholder(child: Text('Tips Screen')),
          settings,
        );

      case statistics:
        return _buildRoute(
          // const StatisticsScreen(),
          const Placeholder(child: Text('Statistics Screen')),
          settings,
        );

      case achievements:
        return _buildRoute(
          // const AchievementsScreen(),
          const Placeholder(child: Text('Achievements Screen')),
          settings,
        );

      case leaderboard:
        return _buildRoute(
          // const LeaderboardScreen(),
          const Placeholder(child: Text('Leaderboard Screen')),
          settings,
        );

      default:
        return _buildRoute(
          const _NotFoundScreen(),
          settings,
        );
    }
  }

  // Helper method to build routes with consistent transitions
  static MaterialPageRoute<T> _buildRoute<T>(
    Widget page,
    RouteSettings settings, {
    bool fullscreenDialog = false,
  }) {
    return MaterialPageRoute<T>(
      builder: (_) => page,
      settings: settings,
      fullscreenDialog: fullscreenDialog,
    );
  }

  // Helper method for slide transitions
  static PageRouteBuilder<T> _buildSlideRoute<T>(
    Widget page,
    RouteSettings settings, {
    SlideDirection direction = SlideDirection.rightToLeft,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Offset getBeginOffset() {
      switch (direction) {
        case SlideDirection.rightToLeft:
          return const Offset(1.0, 0.0);
        case SlideDirection.leftToRight:
          return const Offset(-1.0, 0.0);
        case SlideDirection.topToBottom:
          return const Offset(0.0, -1.0);
        case SlideDirection.bottomToTop:
          return const Offset(0.0, 1.0);
      }
    }

    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // Helper method for fade transitions
  static PageRouteBuilder<T> _buildFadeRoute<T>(
    Widget page,
    RouteSettings settings, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // Helper method for scale transitions
  static PageRouteBuilder<T> _buildScaleRoute<T>(
    Widget page,
    RouteSettings settings, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ));

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }

  // Navigation helper methods
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }

  static Future<bool> maybePop<T extends Object?>(
    BuildContext context, [
    T? result,
  ]) {
    return Navigator.of(context).maybePop<T>(result);
  }

  static void popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.of(context).popUntil(predicate);
  }

  // Convenience methods for common navigation patterns
  static Future<void> goToHome(BuildContext context) {
    return pushNamedAndRemoveUntil(
      context,
      home,
      (route) => false,
    );
  }

  static Future<void> goToLogin(BuildContext context) {
    return pushNamedAndRemoveUntil(
      context,
      login,
      (route) => false,
    );
  }

  static Future<void> goToScan(BuildContext context) {
    return pushNamed(context, scan);
  }

  static Future<void> goToProfile(BuildContext context) {
    return pushNamed(context, profile);
  }

  static Future<void> goToSettings(BuildContext context) {
    return pushNamed(context, settings);
  }
}

enum SlideDirection {
  rightToLeft,
  leftToRight,
  topToBottom,
  bottomToTop,
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '404',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Page Not Found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'The page you are looking for does not exist.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}