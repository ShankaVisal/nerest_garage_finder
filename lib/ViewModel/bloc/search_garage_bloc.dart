import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'search_garage_event.dart';
part 'search_garage_state.dart';

class SearchGarageBloc extends Bloc<SearchGarageEvent, SearchGarageState> {
  SearchGarageBloc() : super(SearchGarageInitial()) {
    on<InitialEvent>(_initialEvent);
    on<NearestGarageSearchEvent>(_nearestGarageSearchEvent);
    on<CallToGarageEvent>(_callToGarageEvent);
  }

  FutureOr<void> _initialEvent(
      InitialEvent event, Emitter<SearchGarageState> emit) {
    emit(InitialState());
  }

FutureOr<void> _nearestGarageSearchEvent(
    NearestGarageSearchEvent event, Emitter<SearchGarageState> emit) async {
  try {
    emit(SearchInProgressState());
    print("🔄 Searching for garages...");

    List<Map<String, dynamic>> finalNearbyGarages = [];

    // Load garage data
    List<dynamic> garages = await _loadGarageData();

    if (garages.isEmpty) {
      emit(SearchErrorState("No garages found in the database."));
      return;
    }

    // Get user location
    Position userLocation = await _determinePosition();
    LatLng userLatLng = LatLng(userLocation.latitude, userLocation.longitude);
    print(userLatLng);

    // Find garages within 5km radius
    List<Map<String, dynamic>> nearbyGarages = _findGaragesWithinRadius(userLocation, garages, event.radius);

    if (nearbyGarages.isEmpty) {
      emit(SearchErrorState("No garages found within 5km of your location."));
      return;
    }

    // Print all garages found
    for (var garage in nearbyGarages) {
      double distance = _calculateDistance(userLocation.latitude, userLocation.longitude, garage['latitude'], garage['longitude']);
      finalNearbyGarages.add({
        "garage":garage,
        "distance":distance.toStringAsFixed(2)
      });
    }

    // Sort garages by distance (optional)
    nearbyGarages.sort((a, b) {
      double distanceA = _calculateDistance(
          userLocation.latitude, userLocation.longitude, a['latitude'], a['longitude']);
      double distanceB = _calculateDistance(
          userLocation.latitude, userLocation.longitude, b['latitude'], b['longitude']);
      return distanceA.compareTo(distanceB);
    });

    // Get the nearest garage (first one in the sorted list)
    Map<String, dynamic> nearestGarage = nearbyGarages.first;
    double distance = _calculateDistance(
        userLocation.latitude, userLocation.longitude, nearestGarage['latitude'], nearestGarage['longitude']);

    emit(
      //SearchResultState("Nearest Garage: ${nearestGarage['name']}, ${nearestGarage['phone']} (${distance.toStringAsFixed(2)} km away)")
      SearchResultState(finalNearbyGarages, userLatLng)
    );
  } catch (e) {
    emit(SearchErrorState("Error: ${e.toString()}"));
  }
}


  Future<List<dynamic>> _loadGarageData() async {
    try {
      var garageList = GlobalConfiguration().getValue("garages");
      return garageList is List ? garageList : [];
    } catch (e) {
      return [];
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) emit(SearchErrorState("Location permissions are denied"));

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // throw Exception('Location permissions are denied');
        emit(SearchErrorState("Location permissions are denied"));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(SearchErrorState("Location permissions are permanently denied"));
      // throw Exception('Location permissions are permanently denied.');
    }
    
    return await Geolocator.getCurrentPosition();
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Earth radius in km
    double dLat = (lat2 - lat1) * pi / 180;
    double dLon = (lon2 - lon1) * pi / 180;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in km
  }

  List<Map<String, dynamic>> _findGaragesWithinRadius(Position userLocation, List<dynamic> garages, double radiusKm) {
    double minDistance = double.infinity;
    List<Map<String, dynamic>>? nearbyGarages = [];

    for (var garage in garages) {
      double distance = _calculateDistance(userLocation.latitude,
          userLocation.longitude, garage["latitude"], garage["longitude"]);

      if (distance < radiusKm) {
        // minDistance = distance;
        nearbyGarages.add(garage);
      }
    }

    return nearbyGarages ;
  }

  FutureOr<void> _callToGarageEvent(
      CallToGarageEvent event, Emitter<SearchGarageState> emit) {
        _callGarage(event.phoneNumber);
  }

  Future<void> _callGarage(String phoneNumber) async {
  final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(callUri)) {
    await launchUrl(callUri);
  } else {
    print("❌ Could not launch $callUri");
  }
}

}
