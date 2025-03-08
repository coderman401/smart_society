class User {
  late String id;
  late String displayName;
  late String email;
  late String? photoUrl;
  late String serverAuthCode;
  late int avilableCoins;

  User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.serverAuthCode,
    required this.avilableCoins,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    serverAuthCode = json['serverAuthCode'];
    avilableCoins = json['avilableCoins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['displayName'] = displayName;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['serverAuthCode'] = serverAuthCode;
    data['avilableCoins'] = avilableCoins;
    return data;
  }
}
