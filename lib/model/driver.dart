class Driver {
  final String nid,
      password,
      fName,
      lName,
      licenseID,
      email,
      phoneNo,
      avatarUrl;

  Driver(
      {this.nid,
      this.password,
      this.fName,
      this.lName,
      this.licenseID,
      this.email,
      this.phoneNo,
      this.avatarUrl});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
        nid: json['nid'],
        fName: json['first_name'],
        lName: json['last_name'],
        licenseID: json['license_number'],
        email: json['email'],
        phoneNo: json['contact_number'],
        avatarUrl: json['avatar_url']);
  }
}
