class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? adress;
  String? createAt;

  UserModel(
      {this.id, this.name, this.email, this.phone, this.adress, this.createAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    adress = json['adress'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['adress'] = this.adress;
    data['createAt'] = this.createAt;
    return data;
  }
}
