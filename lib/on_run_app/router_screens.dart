
import 'package:go_router/go_router.dart';
import 'package:rikaz/on_run_app/splashScreen.dart';
import 'package:rikaz/src/screens/home/home.dart';

class RouterScreens{
  static final GoRouter router = GoRouter(
      initialLocation: "/",

      routes: [

        GoRoute(path: "/",builder: (context, state) => const SplashScreen()),
        GoRoute(path: "/home",builder: (context, state) => const Home()),
        // GoRoute(path: "/edite",builder: (context, state) =>   EditePost()),


      ]);

}
