// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

Map<String, dynamic> responseConverter(String base64Data) {
  List<int> decodedData = base64.decode(base64Data);
  List<int> decompressedData = gzip.decode(decodedData);
  String jsonEncoded = utf8.decode(decompressedData);
  Map<String, dynamic> jsonDecoded = jsonDecode(jsonEncoded);
  return jsonDecoded;
}

String sha1Encode(String input) {
  var bytes = utf8.encode(input);
  var digest = sha1.convert(bytes);
  var result = digest.toString();
  return result;
}

String periodConverter({
  required String? bgnDt,
  required String? endDt,
}) {
  if (bgnDt == null || endDt == null) {
    return '';
  }

  try {
    List<String> bgn = bgnDt.split('-');
    List<String> end = endDt.split('-');
    return '${bgn[0]}.${bgn[1]}.${bgn[2]} ~ ${end[1]}.${end[2]}';
  } catch (e) {
    return '';
  }
}

String setupDateConverter(String? setup_date) {
  if (setup_date == null) {
    return '-';
  }
  List<String> splitted = setup_date.split('-');
  return '${splitted[0]}-${splitted[1]}';
}

int? getYearFromServerDate(String? server_date) {
  if (server_date == null) {
    return null;
  }
  List<String> splitted = server_date.split('-');
  int year = int.parse(splitted[0]);
  return year;
}

int? getMonthFromServerDate(String? server_date) {
  if (server_date == null) {
    return null;
  }
  List<String> splitted = server_date.split('-');
  int month = int.parse(splitted[1]);
  return month;
}

int? getDayFromServerDate(String? server_date) {
  if (server_date == null) {
    return null;
  }
  List<String> splitted = server_date.split('-');
  int day = int.parse(splitted[2]);
  return day;
}

extension DateTimeConverter on DateTime {
  toYYYYMMDD() => '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  toYYYYMM() => '$year-${month.toString().padLeft(2, '0')}';
  String toPhotoFileName() {
    DateTime now = DateTime.now();
    String date =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}_${now.millisecond.toString().padLeft(3, '0')}';
    return '$date.jpg';
  }
}

String photoFileNameConverter(File file) {
  String fileName = file.lastModifiedSync().toPhotoFileName();
  var path = file.path;
  var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
  var newPath = path.substring(0, lastSeparator + 1) + fileName;
  return newPath;
}

String pathWithoutName(String path) {
  var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
  var pathWithoutName = path.substring(0, lastSeparator);
  return pathWithoutName;
}

bool isFilePath(String? path) {
  if (path == null) {
    return false;
  }
  return Directory(path).isAbsolute;
}

bool isSameSeq(dynamic seq1, dynamic seq2) {
  if (seq1 != null) {
    if (seq2 != null) {
      return seq1.toString() == seq2.toString();
    } else {
      return seq1.toString() == '';
    }
  } else {
    if (seq2 != null) {
      return seq2.toString() == '';
    } else {
      return true;
    }
  }
}
