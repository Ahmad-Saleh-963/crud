





// ignore_for_file: non_constant_identifier_names

class ItemsModel{


  ItemsModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.idback,
  });


  int? id;
  int? userId;
  String? title;
  String? body;
  String? idback;




  factory  ItemsModel.fromeJson(Map<String , dynamic> jsonData){
    return  ItemsModel(
      id: jsonData['id'],
      userId: jsonData['userId'],
      title: jsonData['title'],
      body: jsonData['body'],
      idback: jsonData['_id'],
    );
  }




}