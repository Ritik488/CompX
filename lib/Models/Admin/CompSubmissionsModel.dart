class CompSubmissionsModel {
  String imageurl;
  String videourl;
  String competitionname;
  String username;
  String sId;
  String message;
  String competition;
  String user;
  String createdAt;
  String updatedAt;
  int iV;

  CompSubmissionsModel(
      {this.imageurl,
      this.videourl,
      this.competitionname,
      this.username,
      this.sId,
      this.message,
      this.competition,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CompSubmissionsModel.fromJson(Map<String, dynamic> json) {
    imageurl = json['imageurl'];
    videourl = json['videourl'];
    competitionname = json['competitionname'];
    username = json['username'];
    sId = json['_id'];
    message = json['message'];
    competition = json['competition'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageurl'] = this.imageurl;
    data['videourl'] = this.videourl;
    data['competitionname'] = this.competitionname;
    data['username'] = this.username;
    data['_id'] = this.sId;
    data['message'] = this.message;
    data['competition'] = this.competition;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
