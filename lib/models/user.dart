class User {
  int? id;
  String? name;
  String? email;
  String? myReferralCode;
  String? countryId;
  bool? accountStatus;
  String? profilePicture;
  bool? isSubscribed;
  bool? isNewsletterSubscribed;
  bool? trialExpire;
  bool? isVerified;
  String? paypalId;

  User(
      {this.id,
      this.name,
      this.email,
      this.myReferralCode,
      this.countryId,
      this.accountStatus,
      this.profilePicture,
      this.isSubscribed,
      this.isNewsletterSubscribed,
      this.trialExpire,
      this.isVerified,
      this.paypalId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    myReferralCode = json['myReferralCode'];
    countryId = json['countryId'];
    accountStatus = json['accountStatus'];
    profilePicture = json['profilePicture'];
    isSubscribed = json['isSubscribed'];
    isNewsletterSubscribed = json['isNewsletterSubscribed'];
    trialExpire = json['trialExpire'];
    isVerified = json['isVerified'];
    paypalId = json['paypal_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['myReferralCode'] = this.myReferralCode;
    data['countryId'] = this.countryId;
    data['accountStatus'] = this.accountStatus;
    data['profilePicture'] = this.profilePicture;
    data['isSubscribed'] = this.isSubscribed;
    data['isNewsletterSubscribed'] = this.isNewsletterSubscribed;
    data['trialExpire'] = this.trialExpire;
    data['isVerified'] = this.isVerified;
    data['paypal_email'] = this.paypalId;
    return data;
  }

  getImageUrl() => profilePicture != null
      ? "https://mmaflashcards.com$profilePicture"
      : profilePicture;
}
