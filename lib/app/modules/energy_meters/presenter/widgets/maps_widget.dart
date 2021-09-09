import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/core/widgets/square_button.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

class MapsWidget extends StatefulWidget {
  final List<EnergyMeterEntity>? energyMeters;
  final EnergyMeterEntity? selectedEnergyMeter;
  final bool selectMode;
  final LatLng? energyMeterPosition;

  const MapsWidget({
    Key? key,
    this.energyMeters,
    this.selectedEnergyMeter,
    this.selectMode = false,
    this.energyMeterPosition
  }) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  GoogleMapController? mapController;
  late CameraPosition initialLocation;
  late LatLng currentPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Marker? selectedMarker;

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  LatLng? selectPositionMarked;

  @override
  void initState() {
    super.initState();
    initialLocation = CameraPosition(target: LatLng(-16.6367453, -49.2550010), zoom: 13.5);
    generateMarkers();
  }

  void generateMarkers() {
    final energyMeters = widget.energyMeters;
    if (energyMeters == null) return;
    for (var energyMeter in energyMeters) {
      if (energyMeter.latitude != null && energyMeter.longitude != null) {
        addMarker(LatLng(energyMeter.latitude!, energyMeter.longitude!),
            markerId: MarkerId("${energyMeter.id}"),
            onTap: onMarkerTapped
        );
      }
    }
  }

  void addMarker(LatLng position, {MarkerId? markerId, Function? onTap, bool? draggable}) {
    final id = markerId ?? MarkerId("${position.latitude}${position.longitude}");
    final Marker marker = Marker(
      markerId: id,
      position: position,
      draggable: draggable ?? false,
      onTap: () {
        if (onTap != null) onTap(id);
      },
    );
    markers[id] = marker;
  }

  void onMarkerTapped(MarkerId? markerId) {
    setState(() {
      final MarkerId? previousMarkerId = selectedMarker != null ? selectedMarker!.markerId : null;
      if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
        final Marker resetOld = markers[previousMarkerId]!.copyWith(iconParam: BitmapDescriptor.defaultMarker);
        markers[previousMarkerId] = resetOld;
      }

      if (markerId != null) {
        selectMarker(markerId);
      } else {
        selectedMarker = null;
      }
    });
  }

  void selectMarker(markerId) {
    setState(() {
      final Marker? tappedMarker = markers[markerId];
      if (tappedMarker != null) {
        selectedMarker = tappedMarker;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      }
    });
  }

  Future<LatLng> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = LatLng(position.latitude, position.longitude);
    return currentPosition;
  }

  Future<void> animateToCurrentPosition() async {
    animateCameraToPosition(currentPosition);
  }

  void animateCameraToPosition(LatLng position) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 16.0,
        ),
      ),
    );
  }

  Future<void> determineRouteToSelectedMarker() async {
    if (selectedMarker == null) return;
    LatLng startCoordinates = currentPosition;
    LatLng destinationCoordinates = selectedMarker!.position;

    rearrangeMapView(startCoordinates, destinationCoordinates);
    createPolylines(startCoordinates, destinationCoordinates);

  }

  void rearrangeMapView(LatLng start, LatLng destination) {
    double miny = (start.latitude <= destination.latitude) ? start.latitude : destination.latitude;
    double minx = (start.longitude <= destination.longitude) ? start.longitude : destination.longitude;
    double maxy = (start.latitude <= destination.latitude) ? destination.latitude : start.latitude;
    double maxx = (start.longitude <= destination.longitude) ? destination.longitude : start.longitude;

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;

    mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        100.0,
      ),
    );
  }

  // TODO: Necessário ativar Pagamento no Google Cloud para getRouteBetweenCoordinates() funcione
  Future<void> createPolylines(LatLng start, LatLng destination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "", // TODO: Adicionar Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await getCurrentPosition();
    if (widget.selectedEnergyMeter != null) {
      selectMarker(MarkerId("${widget.selectedEnergyMeter!.id}"));
      if (selectedMarker != null) animateCameraToPosition(selectedMarker!.position);
    }

    if (widget.selectMode) {
      if (widget.energyMeterPosition != null) {
        animateCameraToPosition(widget.energyMeterPosition!);
      } else {
        animateToCurrentPosition();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: !widget.selectMode,
              mapType: MapType.normal,
              padding: EdgeInsets.only(top: 30),
              markers: Set<Marker>.of(markers.values),
              polylines: Set<Polyline>.of(polylines.values),
              onTap: (LatLng position) {
                if (!widget.selectMode) {
                  onMarkerTapped(null);
                }
              },
              onCameraMove: (CameraPosition cameraPosition) {
                if (widget.selectMode) {
                  selectPositionMarked = cameraPosition.target;
                }
              },
              onMapCreated: onMapCreated,
            ),
            if (widget.selectMode) buildSelectModeMarker(),
            if (widget.selectMode) buildSelectModeButton(),
            // buildOptionsButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildSelectModeMarker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Center(child: Icon(Icons.location_on, size: 42,)),
    );
  }

  Widget buildSelectModeButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ElevatedButton(
            child: Text("Selecionar"),
            onPressed: () {
              if (selectPositionMarked != null) {
                Modular.to.pop<LatLng>(selectPositionMarked!);
              }
            }
        ),
      ),
    );
  }

  Widget buildOptionsButtons() {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (selectedMarker != null) SquareButton(
                child: Image.asset(AssetIcons.route, height: 24, color: Theme.of(context).iconTheme.color,),
                onPressed: determineRouteToSelectedMarker,
              ),
              SizedBox(height: 10,),
              SquareButton(
                child: Icon(Icons.my_location, color: Theme.of(context).iconTheme.color,),
                onPressed: animateToCurrentPosition,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
