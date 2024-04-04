class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
  });

  String get fullName => '$firstName $lastName';
  String get formattedContactNumber {
    final firstPart = contactNumber.substring(0, 3);
    final secondPart = contactNumber.substring(3, 6);
    final thirdPart = contactNumber.substring(6, contactNumber.length);
    return '+$firstPart-$secondPart-$thirdPart';
  }

  static List<String> nameParts(String fullName) => fullName.split(' ');

  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "user-$camelCaseUsername";

    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        contactNumber: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'Username': generateUsername(fullName),
      'email': email,
      'contactNumber': contactNumber,
    };
  }
}
