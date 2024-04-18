import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:musaneda/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Run app
    await tester.pumpWidget(const App()); // Create main app
    await tester.pumpAndSettle(); // Finish animations and scheduled micro tasks
    await tester.pump(const Duration(seconds: 2)); // Wait some time

    // Enumerate all states that exist in the app just to show we can
    print("All states: ");
    for (var s in tester.allStates) {
      print(s);
    }

    // Find textFields
    final Finder loginView = find.byKey(const ValueKey('login-view'));
    // final Finder homeView = find.byKey(const ValueKey('home-view'));

    // Ensure there is a login and password field on the initial page
    expect(loginView, findsOneWidget);
    // expect(homeView, findsOneWidget);
  });
}
