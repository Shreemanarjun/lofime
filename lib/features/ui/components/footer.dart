import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return const footer(
      classes: 'text-center mt-32 text-white/20 text-[10px] font-black tracking-[0.3em] uppercase py-12 space-y-4',
      [
        div([
          Component.text('Designed for Deep Work'),
        ]),
        div(classes: 'flex justify-center items-center gap-6', [
          a(
            href: 'https://shreeman.dev',
            target: Target.blank,
            classes: 'hover:text-purple-400 transition-colors',
            [Component.text('Portfolio')],
          ),
          span(classes: 'w-1 h-1 bg-white/10 rounded-full', []),
          a(
            href: 'https://github.com/Shreemanarjun/lofime',
            target: Target.blank,
            classes: 'hover:text-purple-400 transition-colors',
            [Component.text('Source')],
          ),
          span(classes: 'w-1 h-1 bg-white/10 rounded-full', []),
          a(
            href: 'https://lofi.shreeman.dev',
            classes: 'hover:text-purple-400 transition-colors opacity-40',
            [Component.text('lofi.shreeman.dev')],
          ),
        ]),
      ],
    );
  }
}
