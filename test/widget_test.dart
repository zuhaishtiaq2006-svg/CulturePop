import 'package:flutter_test/flutter_test.dart';
import 'package:culturepop/main.dart';

void main() {
  testWidgets('CulturePop app loads splash screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const CulturePopApp());
    expect(find.text('CulturePop'), findsWidgets);
  });
}
