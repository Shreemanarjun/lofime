import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' hide Target;
import 'package:universal_web/web.dart' as web;

class Header extends StatefulComponent {
  const Header({super.key});

  @override
  State createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int _visitorCount = 0;

  @override
  void initState() {
    super.initState();
    _loadVisitorCount();
  }

  void _loadVisitorCount() {
    try {
      final stored = web.window.localStorage.getItem('lofime_visitor_count');
      if (stored != null) {
        _visitorCount = int.tryParse(stored) ?? 0;
      }
      // Increment and save
      _visitorCount++;
      web.window.localStorage.setItem('lofime_visitor_count', _visitorCount.toString());
      setState(() {});
    } catch (e) {
      // Fallback if localStorage fails
      _visitorCount = 1;
    }
  }

  @override
  Component build(BuildContext context) {
    return header(classes: 'flex items-center justify-between px-4 sm:px-8 py-4 sm:py-6 max-w-7xl mx-auto w-full relative z-20', [
      // Left side logo + title
      div(classes: 'flex items-center space-x-3 sm:space-x-4 cursor-pointer group', [
        div(
          classes: 'w-10 h-10 sm:w-14 sm:h-14 bg-gradient-to-br from-purple-600 to-pink-500 rounded-2xl sm:rounded-3xl flex items-center justify-center shadow-lg shadow-purple-600/20 group-hover:rotate-12 transition-transform duration-500',
          [
            Radio(width: const Unit.pixels(20), height: const Unit.pixels(20), classes: 'sm:w-7 sm:h-7 text-white'),
          ],
        ),
        const div([
          h1(classes: 'text-xl sm:text-3xl font-black text-white tracking-tight leading-none', [Component.text('lofime')]),
          div(classes: 'flex flex-col mt-1 sm:mt-2', [
            p(classes: 'text-purple-300/60 text-[8px] sm:text-xs font-bold uppercase tracking-widest', [Component.text('Hindi Chill Beats')]),
            span(classes: 'text-white/20 text-[7px] sm:text-[9px] font-medium italic lowercase tracking-wider mt-0.5 sm:mt-1', [
              Component.text('by Shreeman Arjun Sahu ❤️'),
            ]),
          ]),
        ]),
      ]),

      // Right side Navigation/Status
      div(classes: 'flex items-center gap-6', [
        // Visitor Counter
        div(classes: 'hidden md:flex flex-col items-end', [
          const span(classes: 'text-white/40 text-[10px] font-black uppercase tracking-widest', [Component.text('Visitors')]),
          div(classes: 'flex items-center gap-2', [
            Users(width: const Unit.pixels(14), height: const Unit.pixels(14), classes: 'text-purple-400'),
            span(classes: 'text-purple-400 text-lg font-black font-mono', [Component.text(_visitorCount.toString())]),
          ]),
        ]),
        const div(classes: 'hidden sm:flex flex-col items-end', [
          span(classes: 'text-white/60 text-xs font-bold uppercase tracking-tighter', [Component.text('Server Status')]),
          div(classes: 'flex items-center gap-2', [
            div(classes: 'w-2 h-2 bg-green-500 rounded-full animate-pulse', []),
            span(classes: 'text-green-500 text-sm font-bold', [Component.text('ONLINE')]),
          ]),
        ]),
        a(
          href: 'https://github.com/Shreemanarjun/lofime',
          target: Target.blank,
          classes: 'p-3 bg-white/5 hover:bg-white/10 rounded-2xl border border-white/10 transition-all text-white/60 hover:text-white',
          [Github(width: const Unit.pixels(22), height: const Unit.pixels(22))],
        ),
      ]),
    ]);
  }
}
