class Location {
  final String longitude, latitude;

  Location({this.longitude, this.latitude});
}

class Fine {
  final String totalValue, currency, issuedAt, id;
  final Location location;
  final bool isPaid;

  Fine(
      {this.totalValue,
      this.id,
      this.currency,
      this.location,
      this.issuedAt,
      this.isPaid});

  factory Fine.fromJson(Map<String, dynamic> json) {
    return Fine(
        totalValue: json['total_value'].toString(),
        currency: json['currency'],
        location: new Location(
            longitude: json['location']['longitude'],
            latitude: json['location']['latitude']),
        issuedAt: json['issued_at'],
        isPaid: json['is_paid'],
        id: json['_id']);
  }
}
