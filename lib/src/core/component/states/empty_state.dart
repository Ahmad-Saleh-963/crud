




import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';


class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/empty.json",
                height: height / 5),
            AutoSizeText(
              "لايوجد بيانات",
              style: TextStyle(
                  color: ColorsApp.pcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            )
          ],
        ));
  }
}
