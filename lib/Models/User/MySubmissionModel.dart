class SubmissionModel {
  String imageurl;
  String videourl;
  String competitionname;
  String username;
  String useremail;
  String userphoneno;
  String datee;
  String timee;
  String sId;
  String message;
  String competition;
  String user;
  String createdAt;
  String updatedAt;
  int iV;

  SubmissionModel(
      {this.imageurl,
      this.videourl,
      this.competitionname,
      this.username,
      this.useremail,
      this.userphoneno,
      this.datee,
      this.timee,
      this.sId,
      this.message,
      this.competition,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SubmissionModel.fromJson(Map<String, dynamic> json) {
    imageurl = json['imageurl'];
    videourl = json['videourl'];
    competitionname = json['competitionname'];
    username = json['username'];
    useremail = json['useremail'];
    userphoneno = json['userphoneno'];
    datee = json['datee'];
    timee = json['timee'];
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
    data['useremail'] = this.useremail;
    data['userphoneno'] = this.userphoneno;
    data['datee'] = this.datee;
    data['timee'] = this.timee;
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
