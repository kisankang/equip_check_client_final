import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String?>? options;
  final Rx<String?> selectedOption;
  const CustomDropdownMenu({
    super.key,
    required this.options,
    required this.selectedOption,
  });

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late TextEditingController controller;
  late FocusNode focusNode;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    if (widget.options?.contains(widget.selectedOption.value) == false) {
      widget.options?.insert(0, widget.selectedOption.value);
    }
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        focusNode.unfocus();
        widget.selectedOption.value = controller.text;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      child: DropdownMenu<String>(
        requestFocusOnTap: true,
        expandedInsets: const EdgeInsets.all(0),
        initialSelection: widget.selectedOption.value,
        controller: controller,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          surfaceTintColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
          isDense: true,
        ),
        onSelected: (String? newOption) {
          if (newOption != null) {
            widget.selectedOption.value = newOption;
            focusNode.unfocus();
          }
        },
        dropdownMenuEntries: widget.options?.map<DropdownMenuEntry<String>>((String? option) {
              return DropdownMenuEntry<String>(
                value: option ?? '',
                label: option ?? '',
              );
            }).toList() ??
            [],
      ),
    );
  }
}
