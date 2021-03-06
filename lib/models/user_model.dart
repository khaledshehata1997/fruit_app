class UserModel {
  String userid;
  String name;
  String email;
  String pic;
  bool isAdmin;

  UserModel({this.userid, this.name, this.email, this.pic,this.isAdmin});

  UserModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
    email = json['email'];
    pic = json['pic'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['pic'] = this.pic;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}
