// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rikaz/src/core/component/widgets/text_field.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';

import '../../data/models/items_model.dart';
import 'edite_cubit/edite_cubit.dart';

class EditePost extends StatefulWidget {
    EditePost({super.key, required this.item});
    ItemsModel item ;
  @override
  State<EditePost> createState() => _EditePostState();
}

class _EditePostState extends State<EditePost> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<EditeCubit>(context).title.text = widget.item.title.toString();
    BlocProvider.of<EditeCubit>(context).body.text = widget.item.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Todos"),
          centerTitle: true,
          backgroundColor: ColorsApp.pcolor),
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [

              cardData(width),
              SizedBox(height: height*0.02),
              CustomTextField(hintText:  "العنوان",icon: Icons.text_fields,c:BlocProvider.of<EditeCubit>(context).title,typeInput: TextInputType.text),
              SizedBox(height: height*0.02),
              CustomTextField(hintText:"الوصف",icon: Icons.text_fields,c:BlocProvider.of<EditeCubit>(context).body,typeInput: TextInputType.text),
              SizedBox(height: height*0.1),
              GestureDetector(
                onTap: () =>BlocProvider.of<EditeCubit>(context).updateData(widget.item,context),
                child: Container(
                  width: width/2,
                  height: 50,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        ColorsApp.pcolor,
                        ColorsApp.pcolor.withOpacity(0.7),
                        ColorsApp.fkcolor,
                      ])),
                  child: BlocBuilder<EditeCubit, EditeState>(
                      builder: (context, state) {
                        if (state is EditeLoading) {
                          return const Center(
                              child: CircularProgressIndicator(color: Colors.white));
                        }
                        else {
                          return const Center(
                              child: Text("Save",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      decoration: TextDecoration.none)));
                        }

                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  cardData(double width)=> Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.white70, width: 1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [

        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            const SizedBox(width: 10),
            const CircleAvatar(
                radius: 26.0,
                backgroundImage: AssetImage("assets/images/logo.png")
            ),
            const SizedBox(width: 20),
            Flexible(
              child: AutoSizeText(
                  BlocProvider.of<EditeCubit>(context).title.text,
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )
              ),
            ),
          ],
        ),
        Container(
          height: 150,
          margin: const EdgeInsets.only(left: 10, top: 10,right: 10),
          decoration: BoxDecoration(
              color: ColorsApp.pcolor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.contain,
              )
          ),
          width: width,
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 20,right: 25),
          child:
          AutoSizeText(
              BlocProvider.of<EditeCubit>(context).body.text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 5,

                color: Colors.black,
                fontWeight: FontWeight.w400,
              )
          ),
        ),
        const SizedBox(height: 20),

      ],
    ),
  );

}
