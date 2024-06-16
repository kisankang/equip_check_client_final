import 'dart:developer' as developer;

void logInfo(Object? object, {String? des = ''}) {
  String msg = object.toString();
  developer.log('\x1B[36mℹ️ ${des} ---logInfo--- $msg \x1B[0m');
}

void logSuccess(Object? object, {String? des = ''}) {
  String msg = object.toString();
  developer.log('\x1B[32m✅ ${des} ---logSuccess--- $msg \x1B[0m');
}

void logWarning(Object? object, {String? des = ''}) {
  String msg = object.toString();
  developer.log('\x1B[33m⚠️ ${des} ---logWarning--- $msg \x1B[0m');
}

void logError(Object? object, {String? des = ''}) {
  String msg = object.toString();
  developer.log('\x1B[31m❌ ${des} ---logError--- $msg \x1B[0m');
}
