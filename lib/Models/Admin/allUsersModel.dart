class AllUsersModel {
  int role;
  String sId;
  String name;
  String email;
  String salt;
  String encryPassword;
  String phoneno;
  String createdAt;
  String updatedAt;
  int iV;

  AllUsersModel(
      {this.role,
      this.sId,
      this.name,
      this.email,
      this.salt,
      this.encryPassword,
      this.phoneno,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    salt = json['salt'];
    encryPassword = json['encry_password'];
    phoneno = json['phoneno'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['salt'] = this.salt;
    data['encry_password'] = this.encryPassword;
    data['phoneno'] = this.phoneno;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
