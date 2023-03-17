class SocialUserModel {
  String? name ;
  String? email;
  late String phone;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;
  SocialUserModel({
    required this.name,
    this.email,
    required this.phone,
    required this.uId,
    this.image,
    required this.bio,
    this.cover,
    this.isEmailVerified,

  });
  SocialUserModel.fromJson(Map<String , dynamic>? json){
    name=json!['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
    isEmailVerified=json['isEmailVerified'];
  }

Map<String,dynamic> toJson(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'bio':bio,
      'cover':cover,
      'isEmailVerified':isEmailVerified,
    };

}

}