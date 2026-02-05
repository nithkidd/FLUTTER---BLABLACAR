import 'package:blabla/model/ride/ride.dart';

import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/rides_service.dart';

void main() {
  Location dijon = Location(country: Country.france, name: "Dijon");
  RidesService.filterBy(
    departure: Location(name: "Dijon", country: Country.france),
    seatsRequested: 2,
  ); // Shall return 1 ride

  List<Ride> filteredRide = RidesService.filterBy(seatsRequested: 2, departure: dijon);

  for (Ride ride in filteredRide) {
    print(ride);
  }
}
