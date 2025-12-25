import 'package:jaspr_test/jaspr_test.dart';
import 'package:lofime/pages/about_page.dart';

void main() {
  group('About Page', () {
    testComponents('renders about content', (tester) async {
      tester.pumpComponent(const About());

      expect(find.text('About Lofime'), findsOneComponent);
      expect(find.textContaining('modern web application designed for focus'), findsOneComponent);
    });
  });
}
