class Contact {
  late final String userName;
  late final String userPosition;

  Contact({
    required this.userName,
    required this.userPosition,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      userName: json['userName'],
      userPosition: json['userPosition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userPosition': userPosition,
    };
  }
}
