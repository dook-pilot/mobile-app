import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../configs/models.dart';
import '../configs/myclass.dart';

class ZoomImageView extends StatefulWidget {
  final HistoryModel model;
  const ZoomImageView({Key? key, required this.model}) : super(key: key);

  @override
  State<ZoomImageView> createState() => _ZoomImageViewState();
}

class _ZoomImageViewState extends State<ZoomImageView> {
  @override
  Widget build(BuildContext context) {
    var imageFile = File("${MyClass.appDocPath}/${widget.model.id}");
    ImageProvider imageProvider;
    if (imageFile.existsSync()) {
      imageProvider = FileImage(imageFile);
    }
    else {
      imageProvider = NetworkImage(widget.model.image ?? "");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.model.title ?? "", style: const TextStyle(fontSize: 15, color: Colors.white)),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: PhotoView(
        imageProvider: imageProvider,
      ),
    );
  }
}
