class ContactModel {
  final String name;
  final String email;
  final String message;

  ContactModel({
    required this.name,
    required this.email,
    required this.message,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    name: json["name"],
    email: json["email"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "message": message,
  };
}