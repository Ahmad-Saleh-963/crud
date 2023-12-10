// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rikaz/src/core/component/states/empty_state.dart';
import 'package:rikaz/src/core/component/states/loading_state.dart';
import 'package:rikaz/src/core/component/states/noInternet_state.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';
import 'package:rikaz/src/data/data_bloc/itemsbloc_bloc.dart';
import 'package:rikaz/src/data/data_cubit/data_cubit.dart'; 

import '../../core/component/widgets/custom_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ItemsblocBloc>(context).add(ItemsGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorsApp.pcolor,title: const Text("Todos"),centerTitle: true),
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 10),
        child: BlocBuilder<ItemsblocBloc,ItemsblocState>(builder: (context, state) {
          if(state is ItemsblocSucces){
            return   ListView.builder(
              itemCount: BlocProvider.of<ItemsblocBloc>(context).items.length,
              itemBuilder:(context, index) => CustomCard(item: BlocProvider.of<ItemsblocBloc>(context).items[index]),
            );
          }

          else if (state is ItemsblocError){return NoInternetState(
            onTap: ()=>context.read<ItemsblocBloc>().add(ItemsGetEvent()));}
          else if (state is ItemsblocEmpty){return const EmptyState();}
          else {return const LoadingState();}

        },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=> context.push('/addPost'),
        child: const Icon(Icons.add),
      ),

    );
  }
}
