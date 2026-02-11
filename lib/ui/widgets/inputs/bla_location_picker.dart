import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../services/location_service.dart';
import '../../theme/theme.dart';

class BlaLocationPicker extends StatefulWidget {

  const BlaLocationPicker({super.key});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filteredLocations = [];

  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void onSearchChanged(String searchText) {
    List<Location> newSelection = [];

    if (searchText.isNotEmpty) {
      //show location within 1 character of the search text
      newSelection = LocationsService.availableLocations.where((location) =>
      location.name.toUpperCase().contains(searchText.toUpperCase())).toList();
    }

    setState(() {
      filteredLocations = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // searchbar
            BlaSearchBar(
              onBackPressed: onBackSelected,
              onSearchChanged: onSearchChanged,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (ctx, index) => LocationTile(
                  location: filteredLocations[index],
                  onSelected: onLocationSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  final Location location;
  final Function(Location location) onSelected;

  const LocationTile({
    super.key,
    required this.location,
    required this.onSelected,
  });

  String get title => location.name;

  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(
        title,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      subtitle: Text(
        subTitle,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: BlaSize.icon,
      ),
    );
  }
}


// search bar + back button + clear button
// clear button appears only when search is not empty, 
//and clears the search when pressed, 
//also focuses the text field after clearing to allow user to start typing a new search immediately
class BlaSearchBar extends StatefulWidget {
  const BlaSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onBackPressed,
  });

  final Function(String text) onSearchChanged;
  final VoidCallback onBackPressed;

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool get searchIsNotEmpty => _controller.text.isNotEmpty;

  void onChanged(String newText) {
    // notify parent about search text change to update the list of shown locations based on the search
    widget.onSearchChanged(newText);

    // update ui show/hide clear button
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(
          BlaSpacings.radius,
        ), 
      ),
      child: Row(
        children: [
          // Left icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
            child: IconButton(
              onPressed: widget.onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios,
                color: BlaColors.iconLight,
                size: BlaSize.icon,
              ),
            ),
          ),

          Expanded(
            child: TextField(
              focusNode: _focusNode, // focus node to manage focus state
              onChanged: onChanged,
              controller: _controller,
              style: TextStyle(color: BlaColors.textLight),
              decoration: const InputDecoration(
                hintText: "Search for a location",
                border: InputBorder.none, // no border
                filled: false, // no bg color
              ),
            ),
          ),

          searchIsNotEmpty // show clear button only if search is not empty
              ? IconButton(
                  icon: Icon(Icons.close, color: BlaColors.iconLight, size: BlaSize.icon),
                  onPressed: () {
                    _controller.clear();
                    _focusNode.requestFocus(); // keep focus on the text field after clearing
                    onChanged("");
                  },
                )
              : const SizedBox.shrink(), // empty widget when search is empty
        ],
      ),
    );
  }
}
