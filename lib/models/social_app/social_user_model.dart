class SocialUserModel {
 late String name;
  late String email;
 late String phone;
 late String image;
 late String cover;
 late String uId;
 late String bio;
 late bool isEmailVerified;

  SocialUserModel({
    required this.uId,
    required this.email,
    required this.name,
    required this.bio,
    required this.image,
    required this.cover,
    required this.phone,
    required this.isEmailVerified
  });

  SocialUserModel.fromJson(Map<String, dynamic>json){
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}