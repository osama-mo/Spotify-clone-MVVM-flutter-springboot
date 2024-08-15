import 'dart:convert';

class User {
  String name;
  String id;
  String email;
  String token;
  List<String> favoriteSongs;

  User({
    required this.name,
    required this.id,
    required this.email,
    required this.token,
    required this.favoriteSongs,
  });




  User copyWith({
    String? name,
     String? id,
    String? email,
    String? token,
    List<String>? favoriteSongs,
  }) {
    return User(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
      favoriteSongs: favoriteSongs ?? this.favoriteSongs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'token': token,
      'favoriteSongIds': favoriteSongs,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      id: map['id'] ?? 0,
      email: map['username'] ?? '',
      token: map['token'] ?? '',
      favoriteSongs: map['favoriteSongIds'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, id: $id, email: $email, token: $token)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return other.id == id;
      
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ email.hashCode;
}
