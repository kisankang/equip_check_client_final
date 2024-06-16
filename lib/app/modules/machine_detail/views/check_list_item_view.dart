import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/constant/constants.dart';
import 'package:equip_check_client/app/widgets/photo.dart';
import 'package:flutter/material.dart';

class CheckListItemView extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final void Function() onTap;
  const CheckListItemView({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: photoAspectRatio,
            child: Container(
              color: AppColors.gray,
              child: Photo(imageUrl: imageUrl),
            ),
          ),
          Text(
            title ?? '-',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.green,
              fontSize: 12,
            ),
          ),
          Text(
            subtitle ?? '-',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
