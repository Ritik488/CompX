class CompetitionsModel {
  String important;
  String campaignbrief;
  String urls;
  String images;
  String sId;
  String name;
  String description;
  String minidesc;
  String createdAt;
  String updatedAt;
  int iV;

  CompetitionsModel(
      {this.important,
      this.campaignbrief,
      this.urls,
      this.images,
      this.sId,
      this.name,
      this.description,
      this.minidesc,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CompetitionsModel.fromJson(Map<String, dynamic> json) {
    important = json['important'];
    campaignbrief = json['campaignbrief'];
    urls = json['urls'];
    images = json['images'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    minidesc = json['minidesc'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['important'] = this.important;
    data['campaignbrief'] = this.campaignbrief;
    data['urls'] = this.urls;
    data['images'] = this.images;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['minidesc'] = this.minidesc;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}