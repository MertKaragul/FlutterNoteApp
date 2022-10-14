class UserModel{
  late int id;
  late String title;
  late String description;
  late String date;

  UserModel(int id , String title , String description , String date){
    this.id = id;
    this.title = title;
    this.description = description;
    this.date = date;
  }


  Map<String, dynamic> toJson() => {
    'id' : id,
    'title': title,
    'description': description,
    'date': date,
  };

  UserModel.fromJson(Map<String , dynamic> json) :
        id = json["id"] ,
        title = json["title"] ,
        description = json["description"] ,
        date = json["date"];
}