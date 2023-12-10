


import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/data_cubit/data_cubit.dart';
import '../../../data/models/items_model.dart';
import '../../../screens/edite_post/edite_post.dart';
import '../../constants/colors_app.dart';

class CustomCard extends StatelessWidget {
    CustomCard({super.key, required this.item});
    ItemsModel item;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Card(
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
                AutoSizeText(
                    item.title.toString(),
                    maxLines: 4,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    )
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
              child: AutoSizeText(
                item.body.toString(),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 5,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red.shade100,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Builder(
                      builder: (context) {
                        return TextButton(
                          onPressed: () =>BlocProvider.of<DataCubit>(context).showDialogForDeletePost(item.idback.toString(),"Are you sure to delete?",width/2, context ),
                          child: const Text("Delete"),
                        );
                      }
                  ),
                ),),
                const SizedBox(width: 10),
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Builder(
                      builder: (context) {
                        return TextButton(
                          onPressed: ()=>context.push("/edite",extra:item),
                          child: const Text("Edite"),
                        );
                      }
                  ),
                ),),
                const SizedBox(width: 10),

              ],
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}
