class UserProfileModel {
  bool? status;
  String? message;
  ProfileData? data;

  UserProfileModel({this.status, this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
}

class ProfileData {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? image;
  String? status;

  ProfileData({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.image,
    this.status,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    image = json['image'];
    status = json['status'].toString();
  }
}
