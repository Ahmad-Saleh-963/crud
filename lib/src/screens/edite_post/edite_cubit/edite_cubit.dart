

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rikaz/src/data/models/items_model.dart';

import '../../../core/constants/data_constant.dart';
import '../../../data/data_cubit/data_cubit.dart';



part 'edite_state.dart';


class EditeCubit extends Cubit<EditeState> {
  EditeCubit() : super(EditeInitial());


  TextEditingController title  = TextEditingController();
  TextEditingController body  = TextEditingController();
  TextEditingController idUser  = TextEditingController();
  TextEditingController userIdd  = TextEditingController();
  showToast(String msg)=> Fluttertoast.showToast(msg: msg);


   updateData(ItemsModel item,context)async{

     if(body.text.isEmpty){showToast("Enter The Title");return;}
     else if(body.text.isEmpty){showToast("Enter The Discraption");return;}

     emit(EditeLoading());
     Map<String,dynamic> request ={
       "id":item.id,
      // "_id":"${item.idback}",
       "title":title.text,
       "body":body.text,
     };


    try{
      Response response  = await AppData.dio.put("todos/${item.idback}",data: jsonEncode(request));
      if(response.statusCode == 200){
        int i = BlocProvider.of<DataCubit>(context).items.indexWhere((element) => element.id == item.id);
        BlocProvider.of<DataCubit>(context).items[i].title=title.text;
        BlocProvider.of<DataCubit>(context).items[i].body=body.text;
        await AppData.db.updateData('UPDATE data SET body = "${body.text}" , title ="${title.text}" WHERE id = ${item.id} ');
        BlocProvider.of<DataCubit>(context).refrechUi();
         body.clear();
         title.clear();
         Navigator.pop(context);
         emit(EditeInitial());
      }
      else{
        showToast("Erorr Update");
        emit(EditeInitial());
      }

    }catch(e){
      showToast("Erorr Update $e");
      emit(EditeInitial());
    }
    return;

  }

}
