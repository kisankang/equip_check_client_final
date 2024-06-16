import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/widgets/photo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProjectItem extends StatelessWidget {
  bool isSelected;
  bool? needUpdate;
  final void Function()? onTap;
  final String? imageUrl;
  final String? name;
  final String? dris;
  final String? bgnDt;
  final String? endDt;
  ProjectItem({
    super.key,
    this.onTap,
    this.isSelected = false,
    this.needUpdate,
    required this.imageUrl,
    required this.name,
    required this.dris,
    required this.bgnDt,
    required this.endDt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: AppColors.blue, width: 4) : null,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(width: 100, height: 90, color: AppColors.gray, child: Photo(imageUrl: imageUrl)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name ?? '알 수 없음',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              periodConverter(bgnDt: bgnDt, endDt: endDt),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              dris ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (needUpdate != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    needUpdate! ? Icons.circle_outlined : Icons.check_circle_outline,
                    color: AppColors.green,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
