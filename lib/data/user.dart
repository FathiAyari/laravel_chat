class User {
  final int? id;
  final String? name;

  final String? photoUrl;
  final String? email;

  User({this.name, this.photoUrl, this.email, this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['displayName'] != null) {
      return User(
        name: json['displayName'].toString(),
        email: json['email'].toString(),
        photoUrl: json['photoUrl'],
      );
    }
    return User(
      name: json['firstname'].toString(),
      email: json['email'].toString(),
      photoUrl: json['picture']['data']['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
      };
}
