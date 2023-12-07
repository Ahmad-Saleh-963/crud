



// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';

class CustomTextField extends StatelessWidget {
    CustomTextField({super.key, required this.hintText,required this.icon,required this.c,required this.typeInput});

     TextEditingController c;
     String hintText ;
     IconData icon ;
     TextInputType typeInput ;



  @override
  Widget build(BuildContext context) {
    return  Material(
        elevation: 0.0,
        animationDuration: const Duration(seconds: 1),
        color: Colors.transparent,
        child: Center(
          child: TextField(
            controller:c,
            textDirection: TextDirection.rtl,
            keyboardType:typeInput ,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              height: 1,
              // fontFamily: "Cairo"
            ),
            decoration: InputDecoration(
              hintText:hintText,
              hintStyle: const TextStyle(fontSize: 13),
              hintTextDirection: TextDirection.rtl,
              fillColor: ColorsApp.pcolor.withOpacity(0.6),
              suffixIcon: Icon(
                icon,
                color: ColorsApp.pcolor.withOpacity(0.5),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: ColorsApp.pcolor.withOpacity(0.6),
                    width: 2,
                    strokeAlign: 2,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: ColorsApp.pcolor.withOpacity(0.5),
                    width: 2,
                    strokeAlign: 2,
                  )),
              focusColor: ColorsApp.pcolor,
            ),
          ),
        ));
  }
}
