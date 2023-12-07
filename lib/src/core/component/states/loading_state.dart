



import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});


  @override
  Widget build(BuildContext context) {
   // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Lottie.asset("assets/images/loading.json", height: height / 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            AutoSizeText("... يتم التحميل ",
              style: TextStyle(
                  color: ColorsApp.pcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            )
          ],
        ),

      ],
    );
  }
}
