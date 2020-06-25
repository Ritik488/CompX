class UserModel {
	String name;
	String email;
	String phoneno;
	String clas;
	String id;

	UserModel({this.name, this.email, this.phoneno, this.clas, this.id});

	UserModel.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		email = json['email'];
		phoneno = json['phoneno'];
		clas = json['class'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['email'] = this.email;
		data['phoneno'] = this.phoneno;
		data['class'] = this.clas;
		data['id'] = this.id;
		return data;
	}
}