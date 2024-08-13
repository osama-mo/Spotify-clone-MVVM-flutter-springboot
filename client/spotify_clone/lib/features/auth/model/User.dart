import 'dart:convert';

class User {
  String name;
  int id;
  String email;
  String token;

  User({
    required this.name,
    required this.id,
    required this.email,
    required this.token,
  });




  User copyWith({
    String? name,
    int? id,
    String? email,
    String? token,
  }) {
    return User(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      id: map['id'] ?? 0,
      email: map['username'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, id: $id, email: $email, token: $token)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.id == id &&
      other.email == email;
      other.token == token;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ email.hashCode;
}
