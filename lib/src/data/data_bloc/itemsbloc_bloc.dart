import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/constants/colors_app.dart';
import '../../core/constants/data_constant.dart';
import '../data_server/sqlDb.dart';
import '../models/items_model.dart';


part 'itemsbloc_event.dart';
part 'itemsbloc_state.dart';

class ItemsblocBloc extends Bloc<ItemsblocEvent, ItemsblocState> {

  List<ItemsModel> items = [];
  SqlLite db = SqlLite();

  int counter = 0 ;


  ItemsblocBloc() : super(ItemsblocInitial()) {
    on<ItemsblocEvent>((event, emit) async {


      if (event is ItemsGetEvent){
        emit(ItemsblocLoading());
      try {
        Response response = await AppData.dio.get("todos");
        if (response.statusCode == 200 || response.statusCode == 201) {
          items.clear();
          db.deleteData('DELETE FROM data');
          for (int i = 0; i < response.data.length; i ++) {
            items.add(ItemsModel.fromeJson(response.data[i]));
            db.insertData(
                'INSERT INTO data(id,title, userId, body , idback) VALUES(${items[i]
                    .id},"${items[i].title}", ${items[i].userId},"${items[i]
                    .body}","${items[i].idback}")');
          }


          if (items.isEmpty) {emit(ItemsblocEmpty());}
          else {emit(ItemsblocSucces());}
         print("Endddddd");
        }
       else {
          emit(ItemsblocError());
        // getCashData(emit);
       }
      } catch (e) {
        emit(ItemsblocError());
         //getCashData(emit);
      }
    }
      else if(event is ItemsDeleteEvent){}
      else if(event is ItemsRefrechUiEvent){emit(ItemsblocSucces());}
      else{return;}


  });
  }




  getData(Emitter<ItemsblocState>  emit)async{
    emit(ItemsblocLoading());
    try{
      Response response  = await AppData.dio.get("todos");
      if(response.statusCode == 200 || response.statusCode == 201){
        items.clear();
        db.deleteData('DELETE FROM data');
        for(int i = 0 ; i <response.data.length ; i ++){
          items.add(ItemsModel.fromeJson(response.data[i]));
          db.insertData('INSERT INTO data(id,title, userId, body , idback) VALUES(${items[i].id},"${items[i].title}", ${items[i].userId},"${items[i].body}","${items[i].idback}")');
        }


        if(items.isEmpty){
         emit(ItemsblocEmpty());
        }
        else{
          emit(ItemsblocSucces());
        }
        return items;
      }
      else{
       getCashData(emit);
        return [];}
    }catch(e){
      getCashData(emit);
      return [];
    }



  }

  getCashData(Emitter<ItemsblocState>  emit)async{
    showToast("Failed Update Data");
    var data = await db.readData('SELECT * FROM data');
    items.clear();
    for(int i = 0 ; i < data.length ; i++){items.add(ItemsModel.fromeJson(data[i]));}
      emit(ItemsblocSucces());
  }
  showToast(String msg)=> Fluttertoast.showToast(msg: msg);
  /// For Confirm  From App
  showDialogForDeletePost(String id ,String msg, double width, context ,Emitter<ItemsblocState>  emit)async{
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
          deleteData(id,emit);
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

  Future<ItemsModel?> deleteData(String id,Emitter<ItemsblocState>  emit)async{

    try{
      Response response  = await  AppData.dio.delete("todos/$id");
      if(response.statusCode == 200 || response.statusCode == 201 ){
        items.removeWhere((element) => element.idback == id);
        db.deleteData('DELETE FROM data WHERE idback = "$id" ');
        if(items.isEmpty){ emit(ItemsblocEmpty());}
        else{ emit(ItemsblocSucces());}

      }else{showToast("Erorr Delete");}

    }catch(e){
      showToast("Erorr Delete");
    }
    return null;




  }



}
