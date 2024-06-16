import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String?>? list;
  final List<int?>? countList;
  final Rx<String?> selectedValue;
  final String? defaultValue;
  final bool isOutlined;
  final double? borderRadius;
  final AlignmentGeometry alignment;
  const CustomDropdownButton({
    super.key,
    required this.list,
    this.countList,
    required this.selectedValue,
    this.defaultValue,
    required this.isOutlined,
    this.borderRadius,
    this.alignment = AlignmentDirectional.centerStart,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = DropdownButtonHideUnderline(
      child: (list == null || list!.isEmpty) && selectedValue.value == null && defaultValue != null
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                defaultValue!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Obx(
              () => DropdownButton<String>(
                isExpanded: true,
                isDense: !isOutlined,
                iconEnabledColor: Colors.black,
                iconSize: 17,
                icon: const Padding(
                  padding: EdgeInsets.only(right: 11),
                  child: Icon(Icons.arrow_drop_down),
                ),
                value: selectedValue.value,
                items: List.generate(list?.length ?? 0, (index) {
                  String count = '';
                  if (countList?[index] != null) {
                    count = ' [${countList![index]}]';
                  }
                  return DropdownMenuItem<String>(
                    value: list?[index],
                    alignment: alignment,
                    child: Text(
                      (list?[index] ?? '-') + count,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
                onChanged: (String? v) {
                  selectedValue.value = v!;
                },
              ),
            ),
    );
    if (isOutlined) {
      child = Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: child,
      );
    }
    return child;
  }
}
