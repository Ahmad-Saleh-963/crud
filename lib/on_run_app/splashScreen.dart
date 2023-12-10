// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rikaz/on_run_app/router_screens.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';
import 'package:rikaz/src/core/constants/data_constant.dart';
import 'package:rikaz/src/data/data_cubit/data_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  getData()async{
    AppData.initDio();
    BlocProvider.of<DataCubit>(context).getData();
    Future.delayed(const Duration(seconds:2)).then((value) {context.goNamed(RouterScreens.homePage);});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsApp.pcolor,
      body:Center(child: Image.asset("assets/images/logo.png",width:width/2,)),
    );
  }

}