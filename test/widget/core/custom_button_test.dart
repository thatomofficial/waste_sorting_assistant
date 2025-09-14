import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waste_sorting_assistant/core/widgets/custom_button.dart';

void main() {
  group('CustomButton Widget Tests', () {
    testWidgets('should render primary button with text', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Test Button',
              onPressed: () => wasPressed = true,
              type: ButtonType.primary,
            ),
          ),
        ),
      );

      // Find the button
      expect(find.text('Test Button'), findsOneWidget);

      // Tap the button
      await tester.tap(find.text('Test Button'));
      await tester.pumpAndSettle();

      // Verify callback was called
      expect(wasPressed, isTrue);
    });

    testWidgets('should render secondary button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Secondary Button',
              onPressed: () {},
              type: ButtonType.secondary,
            ),
          ),
        ),
      );

      expect(find.text('Secondary Button'), findsOneWidget);
    });

    testWidgets('should render outline button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Outline Button',
              onPressed: () {},
              type: ButtonType.outline,
            ),
          ),
        ),
      );

      expect(find.text('Outline Button'), findsOneWidget);
    });

    testWidgets('should render text button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Text Button',
              onPressed: () {},
              type: ButtonType.text,
            ),
          ),
        ),
      );

      expect(find.text('Text Button'), findsOneWidget);
    });

    testWidgets('should render icon button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              icon: Icons.add,
              onPressed: () {},
              type: ButtonType.icon,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should show loading state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Loading Button',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('should be disabled when enabled is false', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Disabled Button',
              onPressed: () => wasPressed = true,
              enabled: false,
            ),
          ),
        ),
      );

      // Try to tap the disabled button
      await tester.tap(find.text('Disabled Button'));
      await tester.pumpAndSettle();

      // Verify callback was not called
      expect(wasPressed, isFalse);
    });

    testWidgets('should be disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Null OnPressed',
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('Null OnPressed'), findsOneWidget);
      // Button should be present but not interactive
    });

    testWidgets('should render with leading icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Button with Icon',
              onPressed: () {},
              leadingIcon: const Icon(Icons.star),
            ),
          ),
        ),
      );

      expect(find.text('Button with Icon'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should render with trailing icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Button with Trailing Icon',
              onPressed: () {},
              trailingIcon: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );

      expect(find.text('Button with Trailing Icon'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('should render full width button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: CustomButton(
                text: 'Full Width Button',
                onPressed: () {},
                isFullWidth: true,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Full Width Button'), findsOneWidget);

      // Find the button container and check its width
      final buttonFinder = find.ancestor(
        of: find.text('Full Width Button'),
        matching: find.byType(Container),
      );
      expect(buttonFinder, findsWidgets);
    });

    testWidgets('should handle different button sizes', (tester) async {
      // Test small button
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Small Button',
              onPressed: () {},
              size: ButtonSize.small,
            ),
          ),
        ),
      );

      expect(find.text('Small Button'), findsOneWidget);

      // Test medium button
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Medium Button',
              onPressed: () {},
              size: ButtonSize.medium,
            ),
          ),
        ),
      );

      expect(find.text('Medium Button'), findsOneWidget);

      // Test large button
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Large Button',
              onPressed: () {},
              size: ButtonSize.large,
            ),
          ),
        ),
      );

      expect(find.text('Large Button'), findsOneWidget);
    });

    testWidgets('should apply custom colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Custom Color Button',
              onPressed: () {},
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
          ),
        ),
      );

      expect(find.text('Custom Color Button'), findsOneWidget);
    });

    testWidgets('should handle custom padding and border radius', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Custom Style Button',
              onPressed: () {},
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

      expect(find.text('Custom Style Button'), findsOneWidget);
    });

    testWidgets('should show loading in icon button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              icon: Icons.save,
              onPressed: () {},
              type: ButtonType.icon,
              isLoading: true,
            ),
          ),
        ),
      );

      // Should show loading indicator instead of icon
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.save), findsNothing);
    });

    testWidgets('should handle animation correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Animated Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      // Tap and hold
      final gesture = await tester.startGesture(
        tester.getCenter(find.text('Animated Button')),
      );

      await tester.pump(const Duration(milliseconds: 100));

      // Release
      await gesture.up();
      await tester.pumpAndSettle();

      expect(find.text('Animated Button'), findsOneWidget);
    });
  });
}