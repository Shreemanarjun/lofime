import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart';

class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    return header(classes: 'flex items-center justify-between px-8 py-6 max-w-7xl mx-auto w-full relative z-20', [
      // Left side logo + title
      div(classes: 'flex items-center space-x-4 cursor-pointer group', [
        div(
          classes: 'w-14 h-14 bg-gradient-to-br from-purple-600 to-pink-500 rounded-3xl flex items-center justify-center shadow-lg shadow-purple-600/20 group-hover:rotate-12 transition-transform duration-500',
          [
            Radio(width: const Unit.pixels(28), height: const Unit.pixels(28), classes: 'text-white'),
          ],
        ),
        const div([
          h1(classes: 'text-2xl sm:text-3xl font-black text-white tracking-tight', [Component.text('lofime')]),
          p(classes: 'text-purple-300/80 text-xs sm:text-sm font-semibold uppercase tracking-widest', [Component.text('Hindi Chill Beats')]),
        ]),
      ]),

      // Right side Navigation/Status
      div(classes: 'flex items-center gap-6', [
        const div(classes: 'hidden sm:flex flex-col items-end', [
          span(classes: 'text-white/60 text-xs font-bold uppercase tracking-tighter', [Component.text('Server Status')]),
          div(classes: 'flex items-center gap-2', [
            div(classes: 'w-2 h-2 bg-green-500 rounded-full animate-pulse', []),
            span(classes: 'text-green-500 text-sm font-bold', [Component.text('ONLINE')]),
          ]),
        ]),
        button(classes: 'p-3 bg-white/5 hover:bg-white/10 rounded-2xl border border-white/10 transition-all text-white/60 hover:text-white', [Github(width: const Unit.pixels(22), height: const Unit.pixels(22))]),
      ]),
    ]);
  }
}
