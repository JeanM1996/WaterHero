import 'package:waterhero/features/comsumption/domain/models/values_iot.dart';

class RegisterIot {
  //map

  RegisterIot({
    required this.app,
    required this.bestCountry,
    required this.bestId,
    required this.bestLat,
    required this.bestLocation,
    required this.bestLocationType,
    required this.bestLocationWhen,
    required this.bestLon,
    required this.bestTimezone,
    required this.body,
    required this.device,
    required this.event,
    required this.file,
    required this.fleets,
    required this.product,
    required this.received,
    required this.req,
    required this.session,
    required this.triCountry,
    required this.triLat,
    required this.triLocation,
    required this.triLon,
    required this.triPoints,
    required this.triTimezone,
    required this.triWhen,
    required this.when,
  });

  factory RegisterIot.fromJson(Map<String, dynamic> json) {
    return RegisterIot(
      app: json['app'],
      bestCountry: json['best_country'],
      bestId: json['best_id'],
      bestLat: json['best_lat'],
      bestLocation: json['best_location'],
      bestLocationType: json['best_location_type'],
      bestLocationWhen: json['best_location_when'],
      bestLon: json['best_lon'],
      bestTimezone: json['best_timezone'],
      body: ValuesIot.fromJson(json['body']),
      device: json['device'],
      event: json['event'],
      file: json['file'],
      fleets: List<String>.from(json['fleets']),
      product: json['product'],
      received: json['received'],
      req: json['req'],
      session: json['session'],
      triCountry: json['tri_country'],
      triLat: json['tri_lat'],
      triLocation: json['tri_location'],
      triLon: json['tri_lon'],
      triPoints: json['tri_points'],
      triTimezone: json['tri_timezone'],
      triWhen: json['tri_when'],
      when: json['when'],
    );
  }
  String app;
  String bestCountry;
  String bestId;
  double bestLat;
  String bestLocation;
  String bestLocationType;
  num bestLocationWhen;
  num bestLon;
  String bestTimezone;
  ValuesIot body;
  String device;
  String event;
  String file;
  List<String> fleets;
  String product;
  double received;
  String req;
  String session;
  String triCountry;
  double triLat;
  String triLocation;
  double triLon;
  num triPoints;
  String triTimezone;
  num triWhen;
  num when;

  Map<String, dynamic> toJson() {
    return {
      'app': app,
      'best_country': bestCountry,
      'best_id': bestId,
      'best_lat': bestLat,
      'best_location': bestLocation,
      'best_location_type': bestLocationType,
      'best_location_when': bestLocationWhen,
      'best_lon': bestLon,
      'best_timezone': bestTimezone,
      'body': body.toJson(),
      'fleets': fleets,
      'product': product,
      'received': received,
      'req': req,
      'session': session,
      'tri_country': triCountry,
      'tri_lat': triLat,
      'tri_location': triLocation,
      'tri_lon': triLon,
      'tri_points': triPoints,
      'tri_timezone': triTimezone,
      'tri_when': triWhen,
      'when': when,
    };
  }

  @override
  String toString() {
    return 'RegisterIot(app: $app, bestCountry: $bestCountry, bestId: $bestId, bestLat: $bestLat, bestLocation: $bestLocation, bestLocationType: $bestLocationType, bestLocationWhen: $bestLocationWhen, bestLon: $bestLon, bestTimezone: $bestTimezone, body: $body, fleets: $fleets, product: $product, received: $received, req: $req, session: $session, triCountry: $triCountry, triLat: $triLat, triLocation: $triLocation, triLon: $triLon, triPoints: $triPoints, triTimezone: $triTimezone, triWhen: $triWhen, when: $when)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterIot &&
        other.app == app &&
        other.bestCountry == bestCountry &&
        other.bestId == bestId &&
        other.bestLat == bestLat &&
        other.bestLocation == bestLocation &&
        other.bestLocationType == bestLocationType &&
        other.bestLocationWhen == bestLocationWhen &&
        other.bestLon == bestLon &&
        other.bestTimezone == bestTimezone &&
        other.body == body &&
        other.fleets == fleets &&
        other.product == product &&
        other.received == received &&
        other.req == req &&
        other.session == session &&
        other.triCountry == triCountry &&
        other.triLat == triLat &&
        other.triLocation == triLocation &&
        other.triLon == triLon &&
        other.triPoints == triPoints &&
        other.triTimezone == triTimezone &&
        other.triWhen == triWhen &&
        other.when == when;
  }

  @override
  int get hashCode {
    return app.hashCode ^
        bestCountry.hashCode ^
        bestId.hashCode ^
        bestLat.hashCode ^
        bestLocation.hashCode ^
        bestLocationType.hashCode ^
        bestLocationWhen.hashCode ^
        bestLon.hashCode ^
        bestTimezone.hashCode ^
        body.hashCode ^
        fleets.hashCode ^
        product.hashCode ^
        received.hashCode ^
        req.hashCode ^
        session.hashCode ^
        triCountry.hashCode ^
        triLat.hashCode ^
        triLocation.hashCode ^
        triLon.hashCode ^
        triPoints.hashCode ^
        triTimezone.hashCode ^
        triWhen.hashCode ^
        when.hashCode;
  }

  //copy with
  RegisterIot copyWith({
    String? app,
    String? bestCountry,
    String? bestId,
    double? bestLat,
    String? bestLocation,
    String? bestLocationType,
    num? bestLocationWhen,
    double? bestLon,
    String? bestTimezone,
    ValuesIot? body,
    String? device,
    String? event,
    String? file,
    List<String>? fleets,
    String? product,
    double? received,
    String? req,
    String? session,
    String? triCountry,
    double? triLat,
    String? triLocation,
    double? triLon,
    num? triPoints,
    String? triTimezone,
    num? triWhen,
    num? when,
  }) {
    return RegisterIot(
      app: app ?? this.app,
      bestCountry: bestCountry ?? this.bestCountry,
      bestId: bestId ?? this.bestId,
      bestLat: bestLat ?? this.bestLat,
      bestLocation: bestLocation ?? this.bestLocation,
      bestLocationType: bestLocationType ?? this.bestLocationType,
      bestLocationWhen: bestLocationWhen ?? this.bestLocationWhen,
      bestLon: bestLon ?? this.bestLon,
      bestTimezone: bestTimezone ?? this.bestTimezone,
      body: body ?? this.body,
      device: device ?? this.device,
      event: event ?? this.event,
      file: file ?? this.file,
      fleets: fleets ?? this.fleets,
      product: product ?? this.product,
      received: received ?? this.received,
      req: req ?? this.req,
      session: session ?? this.session,
      triCountry: triCountry ?? this.triCountry,
      triLat: triLat ?? this.triLat,
      triLocation: triLocation ?? this.triLocation,
      triLon: triLon ?? this.triLon,
      triPoints: triPoints ?? this.triPoints,
      triTimezone: triTimezone ?? this.triTimezone,
      triWhen: triWhen ?? this.triWhen,
      when: when ?? this.when,
    );
  }
}
