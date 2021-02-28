//Model
class User {
  final int id;
  final String name;
  final String email;

  User({this.id, this.name, this.email});

  User.fromMap(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
      };

  @override
  String toString() => '$id $name $email';
}
