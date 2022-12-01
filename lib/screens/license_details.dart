import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../configs/colors.dart';
import '../configs/configs.dart';
import '../configs/models.dart';
import '../configs/myclass.dart';
import '../widgets/dialogs.dart';

class LicenseDetailActivity extends StatefulWidget {
  final CarDetailsResponse? data;
  const LicenseDetailActivity({Key? key, required this.data}) : super(key: key);

  @override
  State<LicenseDetailActivity> createState() => _LicenseDetailActivityState();
}

class _LicenseDetailActivityState extends State<LicenseDetailActivity> {
  final Completer<GoogleMapController> _controller = Completer();
  CarDetailsResponse? data;

  late CameraPosition _cameraPosition;

  final Map<MarkerId, Marker> _markersList = <MarkerId, Marker>{};

  @override
  void initState() {
    data = widget.data;
    super.initState();

    _cameraPosition = CameraPosition(
      target: LatLng(data?.lat ?? 0, data?.lng ?? 0),
      zoom: 17,
    );

    _markersList[const MarkerId('1')] = Marker(
      markerId: const MarkerId('1'),
      position: LatLng(data?.lat ?? 0, data?.lng ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
            SizedBox(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(data?.selectedFilePath ?? ""),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
                  color: Colors.white,
                ),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _cameraPosition,
                  markers: Set<Marker>.of(_markersList.values),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            if (data != null) _buildCarDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarDetails() {
    var carDetails = data?.license_plate_company_data;

    List<Widget> widgetList = [];
    carDetails?.license_number?.forEach((element) {
      widgetList.add(
        InkWell(
          onTap: () {
            var licenseModel = data?.license_numbers_data?.firstWhere((x) => x?.title == element, orElse: () => null);
            if (licenseModel != null && (licenseModel.status ?? false)) {
              viewDetailsDialog(licenseModel);
            } else {
              showErrorDialog(context, licenseModel?.errMsg ?? "License Detail not found.");
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                const Icon(Icons.radio_button_checked, size: 10),
                const SizedBox(width: 10),
                Text(
                  element ?? "-",
                  style: const TextStyle(fontSize: 15, color: linkColor),
                )
              ],
            ),
          ),
        ),
      );
    });

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (carDetails?.status ?? false) ...[
            Text(
              'Car Details',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                    child: Text(
                      'Company Name',
                      style: TextStyle(fontSize: 14, color: textDarkColor),
                    )),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                      carDetails?.place_api_company_name ?? "-",
                      style: const TextStyle(fontSize: 14, color: textDarkColor),
                    )),
              ],
            ),
            const Divider(thickness: 0.5, height: 15, color: lineColor),
            Row(
              children: [
                const Expanded(
                    child: Text(
                      'KVK',
                      style: TextStyle(fontSize: 14, color: textDarkColor),
                    )),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                      carDetails?.KVK_found ?? "-",
                      style: const TextStyle(fontSize: 14, color: textDarkColor),
                    )),
              ],
            ),
            const Divider(thickness: 0.5, height: 15, color: lineColor),
            Row(
              children: [
                const Expanded(
                    child: Text(
                      'BOVAGE',
                      style: TextStyle(fontSize: 14, color: textDarkColor),
                    )),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                      carDetails?.Bovag_registered ?? "-",
                      style: const TextStyle(fontSize: 14, color: textDarkColor),
                    )),
              ],
            ),
            const Divider(thickness: 0.5, height: 15, color: lineColor),
            Row(
              children: [
                const Expanded(
                    child: Text(
                      'Multiples Companies at same location',
                      style: TextStyle(fontSize: 14, color: textDarkColor),
                    )),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                      carDetails?.duplicates_found ?? "-",
                      style: TextStyle(fontSize: 14, color: textDarkColor),
                    )),
              ],
            ),
            const Divider(thickness: 0.5, height: 15, color: lineColor),
            Row(
              children: [
                const Expanded(
                    child: Text(
                      'Profile Rating',
                      style: TextStyle(fontSize: 14, color: textDarkColor),
                    )),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                      carDetails?.rating ?? "-",
                      style: const TextStyle(fontSize: 14, color: textDarkColor),
                    )),
              ],
            ),
          ] else
            Text(
              carDetails?.errMsg ?? "No car details found.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          const Divider(thickness: 0.5, height: 15, color: lineColor),
          if (carDetails?.license_number?.isNotEmpty == true) ...[
            Row(
              children: [
                const Expanded(
                    child: Text(
                      'Liscense Number',
                      style: TextStyle(fontSize: 14, color: textDarkColor),
                    )),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: widgetList,
                  ),
                ),
              ],
            ),
          ]
          else
            Text(
              "No license number found.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
        ],
      ),
    );
  }

  void viewDetailsDialog(LicenseDetailsModel model) {
    List<Widget> tabList = [];
    List<Widget> tabViewList = [];

    model.categories?.forEach((element) {
      tabList.add(_buildTab(element.title));
      tabViewList.add(_buildTabView(element.sections));
    });

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CONTAINER_RADIUS)),
              clipBehavior: Clip.antiAlias,
              child: Material(
                color: backgroundColor,
                child: DefaultTabController(
                  length: model.categories?.length ?? 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('License: ${model.title}'),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Company: ${model.car_company}'),
                                const Spacer(),
                                Text('Model: ${model.car_model}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: TabBar(
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          tabs: tabList,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: tabViewList,
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildTabView(List<SectionModel> sections) {
    return ListView.separated(
      itemCount: sections.length,
      itemBuilder: (BuildContext context, int index) {
        List<Widget> sectionRows = [];
        for (var element in sections[index].data) {
          sectionRows.add(_buildRow(element.col1 ?? "", element.col2 ?? "", element.col3 ?? "", element.col4, element.info ?? ""));
        }

        return Material(
          color: Colors.white,
          child: ExpansionTile(
            title: Text(sections[index].title, style: const TextStyle(fontSize: 14)),
            children: sectionRows,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 5);
      },
    );
  }

  Widget _buildRow(String text1, String text2, String text3, String? text4, String info) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: Text(text1, style: TextStyle(fontSize: 11))),
          SizedBox(width: 8),
          Expanded(child: Text(text2, style: TextStyle(fontSize: 11))),
          SizedBox(width: 8),
          if (!isBlank(text3)) ...[
            Expanded(child: Text(text3, style: TextStyle(fontSize: 11))),
            SizedBox(width: 8),
          ],
          if (!isBlank(text4)) ...[
            Expanded(child: Text(text4 ?? "", style: TextStyle(fontSize: 10))),
            SizedBox(width: 5),
          ],
          InkWell(
            onTap: () => viewInfoDialog(text2, info),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Icon(Icons.info_outline, size: 18),
            ),
          )
        ],
      ),
    );
  }

  void viewInfoDialog(String title, String description) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CONTAINER_RADIUS)),
              clipBehavior: Clip.antiAlias,
              child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.cancel,
                                color: textMidColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(height: 1, thickness: 1, color: lineColor),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        child: Html(data: description),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
