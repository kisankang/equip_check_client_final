import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  final String? imageUrl;
  const Photo({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl == '') {
      return const Center(
        child: Icon(Icons.photo_outlined, size: 60),
      );
    }

    if (isFilePath(imageUrl)) {
      return Center(
        child: Image.file(
          File(
            imageUrl!,
          ),
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.delete_forever_outlined);
          },
        ),
      );
    }

    if (imageUrl != null) {
      bool isValidUrl = Uri.tryParse(imageUrl!)?.hasAbsolutePath ?? false;
      if (!isValidUrl) {
        return const Center(
          child: Icon(Icons.link_off, size: 60),
        );
      }
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
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
    );
  }
}
