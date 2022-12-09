class User {
  final int? id;
  final String? name;

  final String? avatar;
  final String? email;

  User({this.name, this.avatar, this.email, this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['displayName'] != null) {
      return User(
        name: json['displayName'].toString(),
        email: json['email'].toString(),
        avatar: json['photoUrl'],
      );
    }
    else if ( json['name']!=null){
      return User(
        name: json['name'].toString(),
        email: json['email'].toString(),
        avatar: json['picture']['data']['url'],
      );
    }
    return User(
      name: json['name'].toString(),
      email: json['email'].toString(),
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
      };
}
