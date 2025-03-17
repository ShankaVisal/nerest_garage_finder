import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  // Define two locations (Example: Colombo & Kandy)
  final LatLng location1 = LatLng(6.9271, 79.8612); // Colombo
  final LatLng location2 = LatLng(7.2906, 80.6337); // Kandy

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _setMarkers();
    _getPolyline();
  }

  // Add markers for both locations
  void _setMarkers() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('loc1'),
        position: location1,
        infoWindow: InfoWindow(title: "Colombo"),
      ));

      _markers.add(Marker(
        markerId: MarkerId('loc2'),
        position: location2,
        infoWindow: InfoWindow(title: "Kandy"),
      ));
    });
  }

  // Fetch and draw polyline between two locations
  void _getPolyline() async {
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   "YOUR_GOOGLE_MAPS_API_KEY", // Replace with your API Key
    //   PointLatLng(location1.latitude, location1.longitude),
    //   PointLatLng(location2.latitude, location2.longitude),
    //   travelMode: TravelMode.driving,
    // );

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            googleApiKey: "AIzaSyALNuiCXZUBxsinIpbbCxdKJizY96aZ1cM",
            request: PolylineRequest(
            origin: PointLatLng(location1.latitude, location1.longitude),
            destination: PointLatLng(location2.latitude, location2.longitude),
            mode: TravelMode.driving,
            wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
            ),
    );
    print(result.points);

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates.clear();
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        _polylines.add(Polyline(
          polylineId: PolylineId("route"),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }

  // Adjust map view to fit both markers
  void _fitToBounds() {
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        location1.latitude < location2.latitude ? location1.latitude : location2.latitude,
        location1.longitude < location2.longitude ? location1.longitude : location2.longitude,
      ),
      northeast: LatLng(
        location1.latitude > location2.latitude ? location1.latitude : location2.latitude,
        location1.longitude > location2.longitude ? location1.longitude : location2.longitude,
      ),
    );

    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Map with Polyline & Bounds")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location1,
          zoom: 7,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          _fitToBounds(); // Adjust the view to fit both locations
        },
      ),
    );
  }
}
