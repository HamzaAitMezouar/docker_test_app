class UserModel {
  String displayName;
  String email, password;
  UserModel(
      {required this.email, required this.displayName, required this.password});
  UserModel.fromJson(Map<String, dynamic> json)
      : displayName = json['displayName'],
        password = json['password'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {'displayName': displayName, 'email': email, 'password': password};
  @override
  String toString() {
    // TODO: implement toString
    return 'UserModel{displayName: $displayName, password: $password, email: $email,}';
  }
}
