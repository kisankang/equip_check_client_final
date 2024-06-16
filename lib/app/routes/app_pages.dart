import 'package:get/get.dart';

import '../modules/machine_detail/bindings/machine_detail_binding.dart';
import '../modules/machine_detail/views/machine_detail_view.dart';
import '../modules/machine_list/bindings/machine_list_binding.dart';
import '../modules/machine_list/views/machine_list_view.dart';
import '../modules/find_pw/bindings/find_pw_binding.dart';
import '../modules/find_pw/views/find_pw_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/project_info/bindings/project_info_binding.dart';
import '../modules/project_info/views/project_info_view.dart';
import '../modules/project_list/bindings/project_list_binding.dart';
import '../modules/project_list/views/project_list_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/take_pic/bindings/take_pic_binding.dart';
import '../modules/take_pic/views/take_pic_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.FIND_PW,
      page: () => const FindPwView(),
      binding: FindPwBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT_LIST,
      page: () => const ProjectListView(),
      binding: ProjectListBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT_INFO,
      page: () => const ProjectInfoView(),
      binding: ProjectInfoBinding(),
    ),
    GetPage(
      name: _Paths.MACHINE_LIST,
      page: () => const MachineListView(),
      binding: MachineListBinding(),
    ),
    GetPage(
      name: _Paths.MACHINE_DETAIL,
      page: () => const MachineDetailView(),
      binding: MachineDetailBinding(),
    ),
    GetPage(
      name: _Paths.TAKE_PIC,
      page: () => const TakePicView(),
      binding: TakePicBinding(),
    ),
  ];
}
