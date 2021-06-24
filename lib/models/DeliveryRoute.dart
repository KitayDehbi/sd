class DeliveryRoute {
  DeliveryRoute({this.startLng, this.startLat, this.endLng, this.endLat});

  final String journeyMode =
      'driving-car'; // Change it if you want or make it variable
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;
}
