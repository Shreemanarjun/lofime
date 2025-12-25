import 'package:jaspr_test/jaspr_test.dart';
import 'package:lofime/features/ui/components/header.dart';

void main() {
  group('Header Component', () {
    testComponents('renders title and live indicator', (tester) async {
      tester.pumpComponent(const Header());

      expect(find.text('lofime'), findsOneComponent);
      expect(find.text('ONLINE'), findsOneComponent);
    });
  });
}
