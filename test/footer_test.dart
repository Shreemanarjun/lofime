import 'package:jaspr_test/jaspr_test.dart';
import 'package:lofime/features/ui/components/footer.dart';

void main() {
  group('Footer Component', () {
    testComponents('renders links and description', (tester) async {
      tester.pumpComponent(const Footer());

      expect(find.text('GitHub'), findsOneComponent);
      expect(find.text('About'), findsOneComponent);
      expect(find.text('🎧 LoFi Bollywood • Relax • Study • Chill 🎧'), findsOneComponent);
    });
  });
}
