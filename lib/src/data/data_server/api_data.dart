

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rikaz/src/data/data_server/sqlDb.dart';
import 'package:rikaz/src/data/models/items_model.dart';


class ApiData{

    String baseUrl = "https://jsonplaceholder.typicode.com";
    List<ItemsModel> items =[];




    getData()async{
    final uri  = Uri.parse("$baseUrl/posts");
    try{
      final response  = await http.get(uri);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        items.clear();
        for(int i = 0 ; i < data.length ; i ++){items.add(ItemsModel.fromeJson(data[i]));}
        return items;
      }
      else{
        return [];}
    }catch(e){
      print(e);
      return [];
    }



  }

    Future<ItemsModel?> addData(String title , String body)async{
    Map<String,dynamic> request ={
      "title":title,
      "body":body,
      "userId":"111"
    };

    final uri  = Uri.parse("$baseUrl/posts");

    try{
      final response  = await http.post(uri,body: request);
      if(response.statusCode == 200){
        return ItemsModel.fromeJson(jsonDecode(response.body));
      }else{
       // return [];
      }

    }catch(e){
      print("Erorr");
    }




  }

    Future<ItemsModel?>updateData(String title , String body)async{
    Map<String,dynamic> request ={
      "id":"101",
      "title":title,
      "body":body,
      "userId":"111"
    };

    final uri  = Uri.parse("$baseUrl/posts/1");
    try{
      final response  = await http.put(uri,body: request);
      if(response.statusCode == 200){
        return ItemsModel.fromeJson(jsonDecode(response.body));
      }else{
       // return [];
      }

    }catch(e){
      print("Erorr");
    }




  }

    Future<ItemsModel?> deleteData()async{
    final uri  = Uri.parse("$baseUrl/posts/1");
    try{
      final response  = await http.delete(uri);
      if(response.statusCode == 200){
        return ItemsModel.fromeJson(jsonDecode(response.body));
      }else{
       // return [];
      }

    }catch(e){
      print("Erorr");
    }




  }



}







