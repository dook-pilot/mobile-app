import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:native_exif/native_exif.dart';
import '../configs/api_service.dart';
import '../configs/colors.dart';
import '../configs/configs.dart';
import '../configs/myclass.dart';
import '../widgets/dialogs.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProgressDialog progressDialog = ProgressDialog();
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImage;
  late String _title;
  int _type = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('Upload Image', style: appBarTextStyle()),
          centerTitle: true,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(WIDGET_RADIUS),
                  border: Border.all(color: lineLightColor),
                  color: Colors.white,
                ),
                clipBehavior: Clip.antiAlias,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Material(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(WIDGET_RADIUS),
                          side: const BorderSide(color: lineColor, width: 1),
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
                                    ? Image.asset('assets/images/image.png', height: 50, color: textLightColor)
                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(WIDGET_RADIUS),
                                  child: Image.file(
                                    File(_selectedImage!.path),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text((_selectedImage == null) ? 'Select Image' : _selectedImage!.path.split('/').last, textAlign: TextAlign.center,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        // controller: _firstNameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          labelText: 'Note',
                          labelStyle: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 0.5, color: textLightColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                            borderSide: BorderSide(color: textLightColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                            borderSide: BorderSide(color: textLightColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                            borderSide: BorderSide(color: errorColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                            borderSide: BorderSide(color: errorColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(fontSize: 16, color: textDarkColor),
                        textCapitalization: TextCapitalization.characters,
                        onSaved: (value) {
                          _title = value ?? "";
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(WIDGET_RADIUS),
                            )),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(primaryColor),
                            textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white))),
                        onPressed: () {
                          _formKey.currentState!.save();
                          _requestData();
                        },
                        child: Text('Upload', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
    apiService.uploadFile(uploadFile, _title, MyClass.userId).then((body) async {
      progressDialog.dismiss();

      if (body.status ?? false) {
        _selectedImage = null;
        setState(() {});
        showToast("Your image has been uploaded successfully.");
      } else {
        showErrorDialog(context, body.message);
      }
    }).catchError((error) {
      progressDialog.dismiss();
      showErrorDialog(context, error.toString());
      print(error);
    });
  }
}
