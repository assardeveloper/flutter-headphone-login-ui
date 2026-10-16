import 'package:flutter_test/flutter_test.dart';

import 'package:youtube_videos/headphone_login_page.dart';
import 'package:youtube_videos/main.dart';

void main() {
  testWidgets('Headphone login page loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(HeadphoneLoginPage), findsOneWidget);
  });
}
