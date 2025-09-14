import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waste_sorting_assistant/core/widgets/custom_loader.dart';

void main() {
  group('CustomLoader Widget Tests', () {
    testWidgets('should render circular loader by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should render linear loader', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(type: LoaderType.linear),
          ),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('should render dots loader with animation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(type: LoaderType.dots),
          ),
        ),
      );

      // Should find dot containers
      expect(find.byType(Container), findsWidgets);

      // Pump animation frames
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 200));
    });

    testWidgets('should render pulse loader with animation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(type: LoaderType.pulse),
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);

      // Test animation
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 1000));
    });

    testWidgets('should render wave loader with animation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(type: LoaderType.wave),
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);

      // Test wave animation
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('should display message when provided', (tester) async {
      const message = 'Loading data...';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(
              message: message,
            ),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should render different sizes', (tester) async {
      // Test small size
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(size: LoaderSize.small),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Test medium size
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(size: LoaderSize.medium),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Test large size
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(size: LoaderSize.large),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should apply custom color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(
              color: Colors.red,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show background overlay when enabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(
              showBackground: true,
              backgroundColor: Colors.black54,
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle custom animation duration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLoader(
              animationDuration: Duration(milliseconds: 500),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Test animation timing
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pump(const Duration(milliseconds: 500));
    });
  });

  group('LoaderOverlay Widget Tests', () {
    testWidgets('should show child when not loading', (tester) async {
      const childText = 'Child Widget';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoaderOverlay(
              isLoading: false,
              child: Text(childText),
            ),
          ),
        ),
      );

      expect(find.text(childText), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show loader overlay when loading', (tester) async {
      const childText = 'Child Widget';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoaderOverlay(
              isLoading: true,
              child: Text(childText),
            ),
          ),
        ),
      );

      expect(find.text(childText), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show loader message in overlay', (tester) async {
      const childText = 'Child Widget';
      const loaderMessage = 'Processing...';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoaderOverlay(
              isLoading: true,
              message: loaderMessage,
              child: Text(childText),
            ),
          ),
        ),
      );

      expect(find.text(childText), findsOneWidget);
      expect(find.text(loaderMessage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should use custom loader type in overlay', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoaderOverlay(
              isLoading: true,
              loaderType: LoaderType.dots,
              child: Text('Child'),
            ),
          ),
        ),
      );

      expect(find.text('Child'), findsOneWidget);
      // Dots loader shows containers instead of CircularProgressIndicator
      expect(find.byType(Container), findsWidgets);
    });
  });

  group('LoaderButton Widget Tests', () {
    testWidgets('should render normal button when not loading', (tester) async {
      const buttonText = 'Save';
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoaderButton(
              text: buttonText,
              onPressed: () => wasPressed = true,
              isLoading: false,
            ),
          ),
        ),
      );

      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Test button press
      await tester.tap(find.text(buttonText));
      await tester.pumpAndSettle();

      expect(wasPressed, isTrue);
    });

    testWidgets('should render loading button when loading', (tester) async {
      const buttonText = 'Save';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoaderButton(
              text: buttonText,
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text(buttonText), findsNothing);
    });

    testWidgets('should be disabled when loading', (tester) async {
      const buttonText = 'Save';
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoaderButton(
              text: buttonText,
              onPressed: () => wasPressed = true,
              isLoading: true,
            ),
          ),
        ),
      );

      // Try to tap the loading button
      await tester.tap(find.text('Loading...'));
      await tester.pumpAndSettle();

      // Button should be disabled, so callback shouldn't be called
      expect(wasPressed, isFalse);
    });

    testWidgets('should render button with icon when provided', (tester) async {
      const buttonText = 'Save';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoaderButton(
              text: buttonText,
              onPressed: () {},
              icon: const Icon(Icons.save),
              isLoading: false,
            ),
          ),
        ),
      );

      expect(find.text(buttonText), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
    });

    testWidgets('should apply custom style', (tester) async {
      const buttonText = 'Custom Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoaderButton(
              text: buttonText,
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ),
      );

      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should handle null onPressed', (tester) async {
      const buttonText = 'Disabled Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoaderButton(
              text: buttonText,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text(buttonText), findsOneWidget);
    });
  });
}