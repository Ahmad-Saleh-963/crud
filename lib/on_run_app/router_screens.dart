
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rikaz/on_run_app/error_page.dart';
import 'package:rikaz/on_run_app/splashScreen.dart';
import 'package:rikaz/src/screens/add_post/add_post.dart';
import 'package:rikaz/src/screens/edite_post/edite_post.dart';
import 'package:rikaz/src/screens/home/home.dart';

import '../src/data/models/items_model.dart';

class RouterScreens{

  static String splachScreen = "/";
  static String homePage = "home";
  static String editPage = "edite";
  static String addPage = "addPost";

  static final GoRouter router = GoRouter(
      initialLocation: "/",
      errorBuilder: (context, state) => const ErrorOpenPage(),
      routes: [

        GoRoute(
            name:splachScreen,
            path: "/",builder: (context, state) => const SplashScreen()),
        GoRoute(
            name:homePage,
            path: "/home",
            pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(seconds: 2),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity:CurveTween(curve: Curves.easeInOut).animate(animation),
                      child: child,
                    );
                  },
                  child:  const Home(), //EditePost(item:  null)

                )
        ),
        GoRoute(
            name:addPage,
            path: "/addPost",
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity:CurveTween(curve: Curves.easeInOut).animate(animation),
                    child: child,
                  );
                },
                child: const AddPost(), // context.goNamed("sample",extra:sample);
              );
            }
        ),
        GoRoute(
            name:editPage,
            path: "/edite",
            pageBuilder: (context, state) {
              ItemsModel item = state.extra as ItemsModel;
              return CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity:CurveTween(curve: Curves.easeInOut).animate(animation),
                    child: child,
                  );
                },
                child: EditePost(item: item), // context.goNamed("sample",extra:sample);
              );
            }
        ),

        

      ]

  );


}
