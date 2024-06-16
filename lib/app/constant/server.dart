import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String getAccessKey() {
  String secretKey = dotenv.env['SECRET_KEY']!;
  String today = DateFormat('yyyyMMdd').format(DateTime.now());
  String accessKey = secretKey + today;
  final hash = sha1.convert(utf8.encode(accessKey));
  return hash.toString();
}
