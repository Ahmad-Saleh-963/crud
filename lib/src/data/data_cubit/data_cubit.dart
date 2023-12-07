
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rikaz/src/core/constants/colors_app.dart';
import 'package:rikaz/src/core/constants/data_constant.dart';
import 'package:rikaz/src/data/models/items_model.dart';

import 'package:dio/dio.dart';

import '../data_server/sqlDb.dart';

part 'data_state.dart';


class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  List<ItemsModel> items = [];
  SqlLite db = SqlLite();



  getCashData()async{
    showToast("Failed Update Data");
    var data = await db.readData('SELECT * FROM data');
      items.clear();
      for(int i = 0 ; i < data.length ; i++){items.add(ItemsModel.fromeJson(data[i]));}
    emit(DataSuccess());
  }

  getData()async{
    emit(DataLoading());
    try{
      Response response  = await AppData.dio.get("todos");
      if(response.statusCode == 200 || response.statusCode == 201){
        items.clear();
        db.deleteData('DELETE FROM data');
        for(int i = 0 ; i <response.data.length ; i ++){
          items.add(ItemsModel.fromeJson(response.data[i]));
          db.insertData('INSERT INTO data(id,title, userId, body , idback) VALUES(${items[i].id},"${items[i].title}", ${items[i].userId},"${items[i].body}","${items[i].idback}")');
        }


        if(items.isEmpty){emit(DataEmpty());}
        else{emit(DataSuccess());}
        return items;
      }
      else{ getCashData(); return [];}
    }catch(e){
      getCashData();
      return [];
    }



  }


  Future<ItemsModel?>updateData(int id,String title , String body)async{
    Map<String,dynamic> request ={
      "id":"101",
      "title":title,
      "body":body,
      "userId":"111"
    };

    try{
      Response response  = await AppData.dio.put("posts/$id",data: request);
      if(response.statusCode == 200){
        return ItemsModel.fromeJson(jsonDecode(response.data.toString()));
      }else{
        // return [];
      }

    }catch(e){
      showToast("فشل التحديث");
    }
    return null;

  }

  Future<ItemsModel?> deleteData(String id)async{

    try{
      Response response  = await  AppData.dio.delete("todos/$id");
      if(response.statusCode == 200 || response.statusCode == 201 ){
        items.removeWhere((element) => element.idback == id);
        db.deleteData('DELETE FROM data WHERE idback = "$id" ');
        if(items.isEmpty){ emit(DataEmpty());}
        else{ emit(DataSuccess());}

      }else{showToast("Erorr Delete");}

    }catch(e){
      showToast("Erorr Delete");
    }
    return null;




  }

  showToast(String msg)=> Fluttertoast.showToast(msg: msg);

  /// For Confirm  From App
  showDialogForDeletePost(String id ,String msg, double width, context )async{
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      btnOkColor: ColorsApp.pcolor,
      body: Center(child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17,color: ColorsApp.pcolor),
      ),),
      btnOk: MaterialButton(
        onPressed: ()  {
          Navigator.pop(context);
          deleteData(id);
        },
        padding:   const EdgeInsets.only(left:20, right:20),
        color: Colors.red,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hoverColor: Colors.red,
        textColor: Colors.white,
        child:  const Text("Delete"),
      ),
      btnCancel:MaterialButton(
        onPressed: () =>Navigator.pop(context),
        padding:   const EdgeInsets.only(left:20, right:20),
        color: ColorsApp.pcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        //   height: 30,
        // elevation: 8,
        hoverColor: Colors.red,
        textColor: Colors.white,
        child:  const Text("Cancel"),
      ),
    ).show();
  }

  refrechUi()=>emit(DataSuccess());


}
