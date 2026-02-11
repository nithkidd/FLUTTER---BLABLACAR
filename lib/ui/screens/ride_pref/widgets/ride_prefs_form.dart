import 'package:blabla/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/inputs/bla_location_picker.dart';
import 'ride_prefs_input_tile.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1; // seat will be 1 by default value
      departure = null;
      arrival = null;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onDeparturePressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(builder: (context) => BlaLocationPicker()),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(builder: (context) => BlaLocationPicker()),
    );

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void onSubmit() {
    // search
  }

  void onSwapLocations() {
    setState(() {
      //switch only both fields are defined
      if (departure != null && arrival != null) {
        final temp = departure;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp!);
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get showDeparturePlaceholder => departure == null;
  bool get showArrivalPlaceholder => arrival == null;

  bool get isSwitchVisible =>
      arrival != null &&
      departure !=
          null; // switch is only visible if both departure and arrival are defined

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              // ride departure
              RidePrefsInputTile(
                isPlaceholder: showDeparturePlaceholder,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: onDeparturePressed,
                rightIcon: isSwitchVisible ? Icons.swap_vert : null,
                onRightIconPressed: isSwitchVisible ? onSwapLocations : null,
              ),
              const BlaDivider(),

              // ride arrival
              RidePrefsInputTile(
                isPlaceholder: showArrivalPlaceholder,
                title: arrivalLabel,
                leftIcon: Icons.location_on,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),

              // ride date
              RidePrefsInputTile(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () {},
              ),
              const BlaDivider(),

              // ride number of seats
              RidePrefsInputTile(
                title: numberLabel,
                leftIcon: Icons.person_2_outlined,
                onPressed: () {},
              ),
            ],
          ),
        ),

        // 5 - Launch a search
        BlaButton(color: BlaColors.primary, text: 'Search', onTap: onSubmit),
      ],
    );
  }
}
