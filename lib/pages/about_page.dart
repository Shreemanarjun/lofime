import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:lofime/features/ui/components/background.dart';
import 'package:lofime/features/ui/components/header.dart';

class About extends StatelessComponent {
  const About({super.key});

  @override
  Component build(BuildContext context) {
    return const section([
      AnimatedBackground(),
      div(classes: "relative z-10", [
        Header(),
        main_(classes: "container mx-auto px-4 py-16 text-white max-w-2xl", [
          h1(classes: "text-4xl font-bold mb-8", [Component.text("About Lofime")]),
          p(classes: "text-lg text-purple-200 mb-6", [
            Component.text("Lofime is a modern web application designed for focus and relaxation. "
                "It allows you to stream your favorite lo-fi beats from YouTube with a clean, "
                "minimalist interface and custom controls.")
          ]),
          p(classes: "text-lg text-purple-200 mb-6", [
            Component.text("Built with Jaspr, a modern web framework for Dart, and styled with Tailwind CSS, "
                "Lofime provides a premium user experience with smooth animations and a responsive design.")
          ]),
        ]),
      ]),
    ]);
  }
}
