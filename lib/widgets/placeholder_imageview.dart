import 'package:flutter/material.dart';

class PlaceHolderImage extends StatelessWidget {
  final String image;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const PlaceHolderImage({required this.image, this.fit, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: "assets/images/image_loader.gif",
      image: image,
      width: width,
      height: height,
      fit: fit,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/images/image_failed.png",
          width: width,
          height: height,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
