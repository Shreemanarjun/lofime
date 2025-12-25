import 'package:jaspr_test/jaspr_test.dart';
import 'package:lofime/features/ui/components/background.dart';

void main() {
  group('AnimatedBackground Component', () {
    testComponents('renders background elements', (tester) async {
      tester.pumpComponent(const AnimatedBackground());

      // Should render multiple divs for background effects
      final divs = find.tag('div').evaluate();
      expect(divs.length, greaterThan(0));
    });
  });
}
