

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rikaz/src/data/models/items_model.dart';

import '../../../core/constants/data_constant.dart';
import '../../../data/data_cubit/data_cubit.dart';
import '../../../data/data_server/sqlDb.dart';



part 'add_state.dart';


class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());

  TextEditingController title  = TextEditingController();
  TextEditingController body  = TextEditingController();
  TextEditingController idUser  = TextEditingController();
  TextEditingController userIdd  = TextEditingController();
  showToast(String msg)=> Fluttertoast.showToast(msg: msg);

  addData(context)async{

     if( idUser.text.isEmpty ){showToast("Enter The Id");return;}
     else if( userIdd.text.isEmpty){showToast("Enter The userId");return;}
     else if(title.text.isEmpty){showToast("Enter The Title");return;}
     else if(body.text.isEmpty){showToast("Enter The Discraption");return;}

    emit(AddLoading());
     int id = int.parse(idUser.text);
     int userid = int.parse(userIdd.text);
     Map<String,dynamic> request ={
      "id":id,
      "userId":userid,
      "title":title.text,
      "body":body.text,
    };


    try{
      Response response  = await AppData.dio.post("todos",data: jsonEncode(request)  );
      if(response.statusCode == 200 || response.statusCode == 201){
        ItemsModel item = ItemsModel.fromeJson(response.data);
         BlocProvider.of<DataCubit>(context).items.add(item);
         await AppData.db.insertData('INSERT INTO data(id,title, userId, body, idback ) VALUES(${item.id},"${item.title}", ${item.userId},"${item.body}","${item.idback}" )');
         BlocProvider.of<DataCubit>(context).refrechUi();
         clearTextInput();
         Navigator.pop(context);
         emit(AddInitial());
      }
      else{
        showToast("Erorr Update");
        emit(AddInitial());
      }

    }catch(e){
      showToast("Erorr Update $e");
      emit(AddInitial());
    }
    return;

  }

  clearTextInput(){
    body.clear();
    title.clear();
    userIdd.clear();
    idUser.clear();
  }

}
