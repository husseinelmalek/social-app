class PostModel {
  String? name ;
  String? uId;
  String? image;
  String? text;
  String? dateTime;
  String? postImage;
  PostModel({
    required this.name,
    required this.uId,
    this.image,
    required this.text,
    required this.dateTime,
    required this.postImage,

  });
  PostModel.fromJson(Map<String , dynamic>? json){
    name=json!['name'];
    uId=json['uId'];
    image=json['image'];
    text=json['text'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];
  }

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'text':text,
      'dateTime':dateTime,
      'postImage':postImage,
    };

  }

}