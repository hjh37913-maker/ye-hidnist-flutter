import 'package:flutter_test/flutter_test.dart';
import 'package:ye_hidnist/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Є-Гідність renders', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: YeHidnistApp()));
    await tester.pump();
    expect(find.text('Є-Гідність'), findsWidgets);
  });
}
