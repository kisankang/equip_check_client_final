import 'dart:io';

import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/data/api/app_api.dart';
import 'package:equip_check_client/app/data/repository/app_repository.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_app_data_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  HttpOverrides.global = MyHttpOverrides();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Get.put<LocalAppDataService>(
    LocalAppDataService(),
    permanent: true,
  );
  Get.put<LocalGalleryDataService>(
    LocalGalleryDataService(),
    permanent: true,
  );
  Get.put<LocalMachineDataService>(
    LocalMachineDataService(),
    permanent: true,
  );

  Get.lazyPut<AppAPI>(() => AppAPI());
  Get.put<AppRepository>(
    AppRepository(appAPI: Get.find<AppAPI>()),
    permanent: true,
  );
  Get.put<AppService>(
    AppService(
      appRepository: Get.find<AppRepository>(),
      localAppDataService: Get.find<LocalAppDataService>(),
      localGalleryDataService: Get.find<LocalGalleryDataService>(),
      localMachineDataService: Get.find<LocalMachineDataService>(),
    ),
    permanent: true,
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Equip check client",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blue,
        ),
      ),
      builder: EasyLoading.init(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
