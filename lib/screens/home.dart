import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:native_exif/native_exif.dart';
import 'package:vng_pilot/configs/api_service.dart';
import 'package:vng_pilot/configs/colors.dart';
import 'package:vng_pilot/configs/configs.dart';
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
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            (_selectedImage == null)
                                ? Image.asset('assets/images/image.png', height: 50)
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_selectedImage!.path),
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text((_selectedImage == null) ? 'Select Image' : _selectedImage!.path.split('/').last, textAlign: TextAlign.center,)
                          ],
                        ),
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
          ],
        ),
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
    double? uploadLat = 0;
    double? uploadLng = 0;

    if (_type == 0) {
      var exif = await Exif.fromPath(_selectedImage!.path);
      final lat = await exif.getAttribute("GPSLatitude");
      final lng = await exif.getAttribute("GPSLongitude");
      print(lat);
      print(lng);

      if (lat == null && lng == null) {
        showErrorDialog(context, "This image doesn't have any location coordinates. You can't submit request.");
        return;
      }

      uploadLat = lat;
      uploadLng = lng;

      progressDialog.show(context);
    } else {
      LocationData? locationData = await _fetchLocation();
      if (locationData == null) {
        showToast("Location must be required");
        return;
      }

      uploadLat = locationData.latitude;
      uploadLng = locationData.longitude;

      progressDialog.show(context);

      var exif = await Exif.fromPath(_selectedImage!.path);
      await exif.writeAttributes({"GPSLatitude": locationData.latitude.toString(), "GPSLongitude": locationData.longitude.toString()});
      await exif.close();

      uploadFile = File(_selectedImage!.path);
    }

    final apiService = ApiService.create();
    apiService.carDetailsRequest(uploadFile).then((body) async {
      progressDialog.dismiss();

      if (body.status ?? false) {
        body.lat = uploadLat;
        body.lng = uploadLng;
        body.selectedFilePath = _selectedImage!.path;
        Navigator.pushNamed(context, "/license_details", arguments: body);
      } else {
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
}
