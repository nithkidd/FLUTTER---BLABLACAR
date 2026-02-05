import '../data/dummy_data.dart';
import '../model/ride/ride.dart';
import '../model/ride/locations.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;

  //TODO: Complete the rides service to filter the rides starting from given departure location
  static List<Ride> filterByDeparture(Location departure) {
    return allRides
        .where((ride) => ride.departureLocation == departure)
        .toList();
  }

  // TODO: Complete the rides service to filter the rides for the given requested seat number
  static List<Ride> filterBySeatRequested(int seatRequested) {
    return allRides
        .where((ride) => ride.availableSeats == seatRequested)
        .toList();
  }

  // TODO: Complete the rides service to filter with several optional criteria (flexible filter options)
  static List<Ride> filterBy({
    Location? departure,
    int? seatRequested,
    required int seatsRequested,
  }) {
    return allRides.where((ride) {
      if (departure != null && ride.departureLocation == departure) {
        return false;
      }
      if (seatRequested != null && ride.availableSeats == seatsRequested) {
        return false;
      }
      return true;
    }).toList();
  }
}
