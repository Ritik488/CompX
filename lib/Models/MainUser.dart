class MainUser {
  String token;
  User user;

  MainUser({this.token, this.user});

  MainUser.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String sId;
  String name;
  String email;
  int role;
  String uclass;
  int phoneno;

  User({this.sId, this.name, this.email, this.role, this.uclass, this.phoneno});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    uclass = json['Uclass'];
    phoneno = json['phoneno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['Uclass'] = this.uclass;
    data['phoneno'] = this.phoneno;
    return data;
  }
}