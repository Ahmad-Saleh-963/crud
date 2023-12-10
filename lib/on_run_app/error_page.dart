




// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';


class ErrorOpenPage extends StatelessWidget {
  const ErrorOpenPage({super.key});


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset("assets/images/error.json", height: height / 5),
        AutoSizeText(
          "فشل تحميل الصفحة",
          style: TextStyle(
              color: ColorsApp.pcolor,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        )
      ],
    );
  }
}
