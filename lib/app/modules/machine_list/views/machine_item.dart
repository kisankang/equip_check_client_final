import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/modules/machine_list/views/delete_machine_dialog.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/widgets/photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MachineItem extends StatelessWidget {
  final void Function() onTap;
  final void Function()? onTapConfirmToDelete;
  final String? imageUrl;
  final String? name;
  final String? period;
  final String? location;
  final String? dri;

  const MachineItem({
    super.key,
    required this.onTap,
    required this.onTapConfirmToDelete,
    required this.imageUrl,
    required this.name,
    required this.period,
    required this.location,
    required this.dri,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              color: AppColors.gray,
              child: Photo(
                imageUrl: imageUrl,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name ?? '-',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (onTapConfirmToDelete != null)
                        GestureDetector(
                          onTap: () => showdeleteMachineDialog(onTapConfirm: onTapConfirmToDelete!),
                          child: const Icon(
                            Icons.close,
                            size: 12,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            period ?? DateTime.now().toYYYYMMDD(),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            location ?? '-',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        dri ?? '-',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
