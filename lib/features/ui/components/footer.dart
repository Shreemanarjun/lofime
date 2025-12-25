import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return const footer(
      classes: 'text-center mt-16 text-purple-200/70 text-sm py-8',
      [
        div(classes: 'space-y-4', [
          p([Component.text('🎧 LoFi Bollywood • Relax • Study • Chill 🎧')]),
          p(
            classes: 'text-xs opacity-60',
            [
              Component.text('📺 Streaming curated LoFi Bollywood tracks from YouTube'),
            ],
          ),
          div(classes: 'flex justify-center space-x-4 mt-4', [
            a(
              href: 'https://github.com/Shreemanarjun/lofime',
              target: Target.blank,
              classes: 'hover:text-white transition-colors',
              [Component.text('GitHub')],
            ),
            span([Component.text('|')]),
            a(
              href: '/about',
              classes: 'hover:text-white transition-colors',
              [Component.text('About')],
            ),
          ]),
        ]),
      ],
    );
  }
}
