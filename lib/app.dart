import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_settings.dart';

import 'pages/about.dart';
import 'pages/home.dart';

final container = ProviderContainer();
final talker = Talker();

// The main component of your application.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    // This method is rerun every time the component is rebuilt.

    // Renders a <div class="main"> html element with children.
    return ProviderScope(
      parent: container,
      observers: [
        TalkerRiverpodObserver(
          talker: talker,
          settings: const TalkerRiverpodLoggerSettings(
            printProviderDisposed: true,
          ),
        ),
      ],
      child: div(
        classes: 'main',
        [
          Router(routes: [
            ShellRoute(
              builder: (context, state, child) => fragment([
                // const Header(),
                child,
              ]),
              routes: [
                Route(path: '/', title: 'Home', builder: (context, state) => const Home()),
                Route(path: '/about', title: 'About', builder: (context, state) => const About()),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
