import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();
  static Future<void> openMap(double fromLatitude, double fromLongitude,
      double toLatitude, double toLongitude) async {
    String googleUrl =
        'https://www.google.com/maps/dir/$fromLatitude,$fromLongitude/$toLatitude,$toLongitude/';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
