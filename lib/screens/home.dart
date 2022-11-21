import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:native_exif/native_exif.dart';
import 'package:vng_pilot/configs/api_service.dart';
import 'package:vng_pilot/configs/colors.dart';
import 'package:vng_pilot/configs/configs.dart';
import 'package:vng_pilot/configs/models.dart';
import 'package:vng_pilot/configs/myclass.dart';
import 'package:vng_pilot/widgets/dialogs.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  final ProgressDialog progressDialog = ProgressDialog();
  final ImagePicker _picker = ImagePicker();

  CarDetailsResponse? data;
  XFile? _selectedImage;
  int _type = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('VNG Pilot', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
                borderRadius: BorderRadius.circular(CONTAINER_RADIUS),
                color: Colors.white,
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: textLightColor, width: 1),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        _showImagePicker();
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: (_selectedImage == null)
                                ? Image.asset('assets/images/image.png', height: 50)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(_selectedImage!.path),
                                      height: 50,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                          ),
                          Text('Select Image')
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(WIDGET_RADIUS),
                        )),
                        elevation: MaterialStateProperty.all(3),
                        backgroundColor: MaterialStateProperty.all(primaryColor),
                        textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white))),
                    onPressed: () {
                      _requestData();
                    },
                    child: Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ],
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
            if (licenseModel != null && (licenseModel.isError ?? true) == false) {
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
        borderRadius: BorderRadius.circular(CONTAINER_RADIUS),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          const Divider(thickness: 0.5, height: 15, color: lineColor),
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
        ],
      ),
    );
  }

  Future<LocationData?> _fetchLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        showErrorDialog(context, "Location must be turned on.");
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        showErrorDialog(context, "Location Permission must be allowed.");
        return null;
      }
    }

    return await location.getLocation();
  }

  void _showImagePicker() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CONTAINER_RADIUS)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Image',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.photo_library_sharp, size: 30, color: textDarkColor),
                    minLeadingWidth: 10,
                    title: const Text('Pick From Gallery'),
                    onTap: () async {
                      // _selectedImage = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1100, maxHeight: 700);
                      _selectedImage = await _picker.pickImage(source: ImageSource.gallery);
                      _type = 0;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(thickness: 0.5, height: 15, color: lineColor),
                  ListTile(
                    leading: Icon(Icons.camera_alt, size: 30, color: textDarkColor),
                    minLeadingWidth: 10,
                    title: const Text('Take From Camera'),
                    onTap: () async {
                      // _selectedImage = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1100, maxHeight: 700);
                      _selectedImage = await _picker.pickImage(source: ImageSource.camera);
                      _type = 1;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _requestData() async {
    if (_selectedImage == null) {
      showToast("Please select image");
      return;
    }

    File uploadFile = File(_selectedImage!.path);

    if (_type == 0) {
      var exif = await Exif.fromPath(_selectedImage!.path);
      final lat = await exif.getAttribute("GPSLatitude");
      final lng = await exif.getAttribute("GPSLongitude");
      print(lat);
      print(lng);

      //if (lat == null && lng == null) {
      //  showErrorDialog(context, "This image doesn't have any location coordinates. You can't submit request.");
      //  return;
      //}

      setState(() => data = null);
      progressDialog.show(context);
    } else {
      LocationData? locationData = await _fetchLocation();
      if (locationData == null) {
        showToast("Location must be required");
        return;
      }

      setState(() => data = null);
      progressDialog.show(context);

      var exif = await Exif.fromPath(_selectedImage!.path);
      await exif.writeAttributes({"GPSLatitude": locationData.latitude.toString(), "GPSLongitude": locationData.longitude.toString()});
      await exif.close();

      uploadFile = File(_selectedImage!.path);
    }

    final apiService = ApiService.create();
    apiService.carDetailsRequest(uploadFile).then((body) async {
      progressDialog.dismiss();

      if ((body.isError ?? true) == false) {
        setState(() => data = body);
      }
      else {
        showErrorDialog(context, body.errMsg);
      }
    }).catchError((error) {
      progressDialog.dismiss();
      showErrorDialog(context, error.toString());
      print(error);
    });

    // var exif = await Exif.fromPath(_selectedImage!.path);
    // final originalDate = await exif.getOriginalDate();
    // var attributes = await exif.getAttributes();
    // print(originalDate);
    // print(attributes);

    // if (lat > 0) {
    //   exif.setAttribute(ExifInterface.TAG_GPS_LATITUDE_REF, "N");
    // } else {
    //   exif.setAttribute(ExifInterface.TAG_GPS_LATITUDE_REF, "S");
    // }
    //
    // if (lng > 0) {
    //   exif.setAttribute(ExifInterface.TAG_GPS_LONGITUDE_REF, "E");
    // } else {
    //   exif.setAttribute(ExifInterface.TAG_GPS_LONGITUDE_REF, "W");
    // }

    // await exif.writeAttributes({"GPSLatitude": "13.02",  "GPSLongitude": "152.02"});
    // // await exif.writeAttribute("Longitude", "23.0232");
    // await exif.close();
    //
    // exif = await Exif.fromPath(_selectedImage!.path);
    // attributes = await exif.getAttributes();
    // // var lat = await exif.getAttribute("GPSLatitude");
    // print(attributes);
    // // print(lat);

    // final apiService = ApiService.create();
    // apiService.temp(uploadFile).then((body) async {
    //   progressDialog.dismiss();
    //   print(body);
    // }).catchError((error) {
    //   progressDialog.dismiss();
    //   handleError(context, error);
    //   print(error);
    // });
  }

  // Future<void> _requestLicenseData(String licenseNo) async {
  //   progressDialog.show(context);
  //
  //   final apiService = ApiService.create();
  //   apiService.getLicenseDetail(licenseNo).then((body) async {
  //     progressDialog.dismiss();
  //
  //     if (body.status == 200) {
  //       _map[licenseNo] = body;
  //       viewDetailsDialog(body);
  //     } else {
  //       showToast("No record found!");
  //     }
  //   }).catchError((error) {
  //     progressDialog.dismiss();
  //     handleError(context, error);
  //     print(error);
  //   });
  // }

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
