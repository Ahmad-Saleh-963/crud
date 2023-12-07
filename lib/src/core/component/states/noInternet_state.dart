




// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';


class NoInternetState extends StatelessWidget {
   NoInternetState({super.key, required this.onTap});
   void Function()? onTap;

  @override
  Widget build(BuildContext context) {
 //   double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap ,// () async {await BlocProvider.of<MainCategoryCubit>(context).getAllMainCategory(context);},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Lottie.asset("assets/images/error.json", height: height / 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.refresh, color: ColorsApp.pcolor,size: 15),
              const SizedBox(width: 5),
              AutoSizeText(
                "إعادة تحميل",
                style: TextStyle(
                    color: ColorsApp.pcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
