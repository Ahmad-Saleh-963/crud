import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rikaz/on_run_app/router_screens.dart';
import 'package:rikaz/src/data/data_bloc/itemsbloc_bloc.dart';
import 'package:rikaz/src/data/data_cubit/data_cubit.dart';
import 'package:rikaz/src/screens/add_post/add_cubit/add_cubit.dart';
import 'package:rikaz/src/screens/edite_post/edite_cubit/edite_cubit.dart';

void main() => runApp(const MyApp());



class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => DataCubit()),
        BlocProvider(create: (context) => EditeCubit()),
        BlocProvider(create: (context) => AddCubit()),

        BlocProvider(create: (context) => ItemsblocBloc()),

      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: RouterScreens.router,
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }


}
