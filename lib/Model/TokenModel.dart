class TokenModel {
  String? message;
  String? jwt;
  String? pid;
  String? ssno;
  String? firstname;
  String? lastname;
  String? hname;
  String? email;
  int? expireAt;

  TokenModel(
      {this.message,
      this.jwt,
      this.pid,
      this.ssno,
      this.firstname,
      this.lastname,
      this.hname,
      this.email,
      this.expireAt});

  TokenModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    jwt = json['jwt'];
    pid = json['pid'];
    ssno = json['ssno'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    hname = json['hname'];
    email = json['email'];
    expireAt = json['expireAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['jwt'] = this.jwt;
    data['pid'] = this.pid;
    data['ssno'] = this.ssno;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['hname'] = this.hname;
    data['email'] = this.email;
    data['expireAt'] = this.expireAt;
    return data;
  }
}
