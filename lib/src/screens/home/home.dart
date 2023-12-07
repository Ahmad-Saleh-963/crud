// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rikaz/src/core/component/states/empty_state.dart';
import 'package:rikaz/src/core/component/states/loading_state.dart';
import 'package:rikaz/src/core/component/states/noInternet_state.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';
import 'package:rikaz/src/data/data_cubit/data_cubit.dart';
import 'package:rikaz/src/screens/add_post/add_post.dart';

import '../../core/component/widgets/custom_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorsApp.pcolor,title: const Text("Todos"),centerTitle: true),
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 10),
        child: BlocBuilder<DataCubit,DataState>(builder: (context, state) {
          if(state is DataSuccess){
            return   ListView.builder(
              itemCount: BlocProvider.of<DataCubit>(context).items.length,
              itemBuilder:(context, index) => CustomCard(item: BlocProvider.of<DataCubit>(context).items[index]),
            );
          }

          else if (state is DataError){return NoInternetState(onTap: (){BlocProvider.of<DataCubit>(context).getData();});}
          else if (state is DataEmpty){return const EmptyState();}
          else {return const LoadingState();}

        },
        ),
      ),

       floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost())),
         child: const Icon(Icons.add),
    ),

    );
  }

}
