import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:flutter/material.dart';

class PhotoViewer extends StatelessWidget {
  final String? imagePath;
  const PhotoViewer({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildWidget(Widget child) => Scaffold(
          body: Center(
              child: InteractiveViewer(
            clipBehavior: Clip.none,
            child: child,
          )),
        );

    if (imagePath == null || imagePath == '') {
      return buildWidget(
        const Center(
          child: Icon(Icons.photo_outlined, size: 60),
        ),
      );
    }

    if (isFilePath(imagePath!)) {
      return buildWidget(Image.file(File(imagePath!)));
    }

    bool isValidUrl = Uri.tryParse(imagePath!)?.hasAbsolutePath ?? false;
    if (!isValidUrl) {
      return buildWidget(
        const Center(
          child: Icon(Icons.link_off, size: 60),
        ),
      );
    }

    return buildWidget(
      CachedNetworkImage(
        imageUrl: imagePath!,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          );
        },
        errorWidget: (context, url, error) {
          return const Center(
            child: Icon(
              Icons.error_outline,
              size: 60,
            ),
          );
        },
      ),
    );
  }
}
