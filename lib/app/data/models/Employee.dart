class Employee {
  String? id;
  String? uid;
  String name;
  String email;
  String role;
  String createdAt;
  String updatedAt;

  Employee({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    uid: json["uid"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "name": name,
    "email": email,
    "role": role,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}