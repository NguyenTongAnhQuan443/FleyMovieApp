class User {
  final String? userID;
  final String? name;
  final DateTime? sevicePack;
  final int? numSevicePack;
  final String? expiry;

  User(
      {this.userID,
      this.name,
      this.sevicePack,
      this.numSevicePack,
      this.expiry});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      name: json['name'],
      sevicePack: json['sevicePack'] != null
          ? DateTime.parse(json['sevicePack'])
          : null,
      numSevicePack: json['numSevicePack'],
      expiry: json['expiry'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'name': name,
        'sevicePack': sevicePack?.toIso8601String(),
        'numSevicePack': numSevicePack,
        'expiry': expiry,
      };
}
