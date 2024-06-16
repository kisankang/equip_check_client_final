// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/widgets/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

showCustomDatePickerDialog({
  required String title,
  required Rx<String?> server_date,
  required bool needDay,
}) {
  Get.dialog(
    CustomDatePickerDialog(
      title: title,
      server_date: server_date,
      needDay: needDay,
    ),
    barrierColor: Colors.transparent,
  );
}

// ignore: must_be_immutable
class CustomDatePickerDialog extends StatelessWidget {
  final String title;
  final Rx<String?> server_date;
  final bool needDay;
  CustomDatePickerDialog({
    super.key,
    required this.title,
    required this.server_date,
    required this.needDay,
  }) {
    selectedDateTime = DateTime(
      getYearFromServerDate(server_date.value) ?? now.year,
      getMonthFromServerDate(server_date.value) ?? now.month,
      needDay ? getDayFromServerDate(server_date.value) ?? now.day : now.day,
    );
  }
  DateTime get now => DateTime.now();
  late DateTime selectedDateTime;
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '날짜 변경',
      onTapConfirm: () {
        server_date.value = needDay ? selectedDateTime.toYYYYMMDD() : selectedDateTime.toYYYYMM();
      },
      child: SizedBox(
        height: 200,
        child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: GlobalCupertinoLocalizations.delegates,
            supportedLocales: const [
              Locale('ko', 'KR'),
            ],
            locale: const Locale('ko', 'KR'),
            builder: (context, widget) {
              return CupertinoDatePicker(
                initialDateTime: selectedDateTime,
                mode: needDay ? CupertinoDatePickerMode.date : CupertinoDatePickerMode.monthYear,
                onDateTimeChanged: (DateTime changedDate) {
                  selectedDateTime = changedDate;
                },
              );
            }),
      ),
    );
  }
}
