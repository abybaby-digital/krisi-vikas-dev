import 'dart:math';

double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
  const double earthRadius = 6371.0; // in kilometers

  double lat1 = _degreesToRadians(startLatitude);
  double lon1 = _degreesToRadians(startLongitude);
  double lat2 = _degreesToRadians(endLatitude);
  double lon2 = _degreesToRadians(endLongitude);

  double deltaLon = lon2 - lon1;

  num numerator = pow(cos(lat2) * sin(deltaLon), 2) +
      pow(cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(deltaLon), 2);
  double denominator = sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(deltaLon);

  double deltaSigma = atan2(sqrt(numerator), denominator);
  double distance = earthRadius * deltaSigma;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180.0;
}
