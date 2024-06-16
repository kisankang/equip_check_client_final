// ignore_for_file: non_constant_identifier_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:collection/collection.dart';
import 'package:equip_check_client/app/constant/constants.dart';
import 'package:equip_check_client/app/data/models/picture_cate_item.dart';
import 'package:equip_check_client/app/data/models/new_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/modules/machine_detail/controllers/machine_detail_controller.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/utils/helper.dart';
import 'package:equip_check_client/app/widgets/custom_orientation_builder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image/image.dart' as img;

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equip_check_client/app/data/models/check_list_item.dart';
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TakePicController extends GetxController {
  final AppService _appService;
  final LocalGalleryDataService _localGalleryDataService;
  TakePicController({
    required AppService appService,
    required LocalGalleryDataService localGalleryDataService,
  })  : _appService = appService,
        _localGalleryDataService = localGalleryDataService;
  late String project_seq;
  late Project project;
  late String mid;
  late Machine machine;

  List<CheckListItem> get checkList => _machineDetailController.checkList as List<CheckListItem>;
  List<int?>? get checkListItemCountList {
    List<int?>? list = _machineDetailController.checkListItemCountList.value?.toList();
    list?.removeAt(0);
    return list;
  }

  late Rx<String?> selectedCheckListItemName;
  String get selectedCheckListItemSeq =>
      checkList.singleWhere((element) => element.name == selectedCheckListItemName.value).seq;

  List<PictureCateItem?>? get pictureCateList =>
      checkList.singleWhere((element) => element.name == selectedCheckListItemName.value).picture_cate_list?.toList();
  List<int?>? get pictureCateCountList {
    List<int?>? countList = [];
    if (pictureCateList != null) {
      for (PictureCateItem? pictureCateItem in pictureCateList!) {
        List? gallery = _machineDetailController.machine.value?.gallery
            ?.where((element) =>
                isSameSeq(element.cate_seq, pictureCateItem?.seq) &&
                isSameSeq(element.check_seq, selectedCheckListItemSeq))
            .toList();
        int? count = gallery?.length;
        countList.add(count);
      }
    }
    return countList;
  }

  late Rx<String?> selectedPictureCateItemName;
  String? get selectedPictureCateItemSeq =>
      pictureCateList?.singleWhere((element) => element?.name == selectedPictureCateItemName.value)?.seq;

  late CameraController cameraController;
  Rx<FlashMode> flashMode = Rx(FlashMode.off);
  onTapFlash() {
    if (flashMode.value == FlashMode.off) {
      flashMode.value = FlashMode.torch;
    } else {
      flashMode.value = FlashMode.off;
    }
    cameraController.setFlashMode(flashMode.value);
  }

  final Audio _audio = Audio("assets/audios/shutter.mp3");

  late MachineDetailController _machineDetailController;

  Directory? targetDir;
  initTargetDir() async {
    if (await checkPermission()) {
      try {
        Directory? rootDir = findRoot(await getExternalStorageDirectory());
        rootDir ??= await getApplicationDocumentsDirectory();

        targetDir = await Directory('${rootDir.path}/Pictures/Elim/${project.name ?? '현장명'}/${machine.name ?? '설비명'}')
            .create(recursive: true);
      } catch (e) {
        EasyLoading.showError('디렉토리');
      }
    }
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      return await sourceFile.rename(newPath);
    } on FileSystemException catch (_) {
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }

  Future<bool> checkPermission() async {
    bool cameraGranted = true;
    bool storageGranted = true;
    int maxTry = 0;
    while (!await Permission.camera.isGranted) {
      cameraGranted = await Permission.camera.request().isGranted;
      maxTry++;
      if (maxTry > 5) {
        break;
      }
    }

    if (await getAndroidSdkVersion() >= 33) {
      while (!await Permission.manageExternalStorage.isGranted) {
        storageGranted = await Permission.manageExternalStorage.request().isGranted;
        maxTry++;
        if (maxTry > 5) {
          break;
        }
      }
    } else {
      while (!await Permission.storage.isGranted) {
        storageGranted = await Permission.storage.request().isGranted;
        maxTry++;
        if (maxTry > 5) {
          break;
        }
      }
    }

    if (!cameraGranted || !storageGranted) {
      Get.back();
      EasyLoading.showError('권한을 확인해주세요');
      return false;
    } else {
      return true;
    }
  }

  @override
  onInit() {
    initTargetDir();
    _machineDetailController = Get.find<MachineDetailController>();
    project_seq = Get.parameters['project_seq']!;
    project = _appService.projectList.value.singleWhere((element) => element.seq == project_seq);
    mid = Get.parameters['mid']!;
    machine = _appService.machineList.value[project_seq]!.singleWhere((element) => isSameSeq(element.mid, mid));
    machine.location ??= _appService.projectList.value
        .singleWhere((element) => isSameSeq(element.seq, project_seq))
        .location_list
        ?.firstOrNull;
    if (_machineDetailController.selectedCheckListItemName.value == '전체') {
      selectedCheckListItemName = Rx(_machineDetailController.checkListItemNameList.value?[1]);
    } else {
      selectedCheckListItemName = Rx(_machineDetailController.selectedCheckListItemName.value);
    }
    selectedPictureCateItemName = Rx(pictureCateList?.first?.name);
    selectedCheckListItemName.listen((p0) {
      selectedPictureCateItemName.value = pictureCateList?.first?.name;
    });
    initCamera();
    super.onInit();
  }

  Rx<bool> isInitializedCamera = Rx(false);
  initCamera() async {
    try {
      var cameras = await availableCameras();
      var camera = cameras.first;
      cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController.initialize();
      await cameraController.setFlashMode(FlashMode.off);
      isInitializedCamera.value = true;
    } catch (e) {
      Get.back();
      EasyLoading.showError('카메라 접근 권한을 확인해주세요');
    }
  }

  @override
  Future<void> onClose() async {
    await cameraController.setFlashMode(FlashMode.off);
    super.onClose();
  }

  @override
  dispose() async {
    cameraController.dispose();
    super.dispose();
  }

  Rx<CustomOrientation> orientation = Rx(CustomOrientation.portrait);

  double cameraHeight(bool isPortrait) {
    if (isPortrait) {
      return Get.size.width / photoAspectRatio;
    } else {
      return Get.size.width * photoAspectRatio;
    }
  }

  Rx<bool> blink = Rx(false);
  blinking() async {
    AssetsAudioPlayer.playAndForget(_audio);
    blink.value = true;
    await Future.delayed(const Duration(milliseconds: 50));
    blink.value = false;
  }

  Rx<List<File>> photos = Rx([]);

  Rx<bool> isTakingPhoto = Rx(false);

  Future<XFile?> _takePhoto() async {
    XFile? photo;
    isTakingPhoto.value = true;
    blinking();
    try {
      photo = await cameraController.takePicture();
    } catch (e) {
      logError(e, des: 'TakePicController._takePhoto()');
    }
    isTakingPhoto.value = false;
    return photo;
  }

  onTapTakePhoto() async {
    try {
      XFile? photo = await _takePhoto();
      File? processed;
      if (photo != null) {
        processed = await _imageFileProcessing(
          xfile: photo,
          needRotate: orientation.value != CustomOrientation.portrait,
        );
      }
      if (processed != null) {
        photos.update((val) {
          val?.add(processed!);
        });
        await createGalleryPicture(processed.path);
      } else {
        logError('file from _imageFileProcessing is null');
      }
    } catch (e) {
      logError(e, des: 'TakePicController.takePhoto()');
    }
  }

  createGalleryPicture(String file_path) async {
    try {
      NewGalleryPicture newGalleryPicture = NewGalleryPicture(
        project_seq: project_seq,
        machine_seq: machine.seq,
        check_seq: selectedCheckListItemSeq,
        cate_seq: selectedPictureCateItemSeq,
        title: null,
        value: null,
        userfile: null,
        file_path: file_path,
        file_name: file_path.split(Platform.pathSeparator).last,
        update_time: null,
        seq: null,
        pid: DateTime.now().millisecondsSinceEpoch.toString(),
        mid: mid,
      );

      await _localGalleryDataService.addNewGallery(newGalleryPicture);
      _appService.reflectGalleryChanges(newGalleryPicture.toGalleryItem());
      logSuccess(newGalleryPicture.seq, des: 'TakePicController.createGalleryPicture()');
    } catch (e) {
      logError(e, des: 'TakePicController.createGalleryPicture()');
    }
  }

  Future<File?> _imageFileProcessing({
    required XFile xfile,
    required bool needRotate,
  }) async {
    File? savedFile;
    try {
      var decodedImage = await decodeImageFromList(File(xfile.path).readAsBytesSync());

      int resizedWidth = decodedImage.width;
      int resizedHeight;
      if (orientation.value == CustomOrientation.portrait) {
        resizedHeight = (resizedWidth / photoAspectRatio).round();
      } else {
        resizedHeight = (resizedWidth * photoAspectRatio).round();
      }

      int offsetX = 0;
      int offsetY = ((decodedImage.height - resizedHeight) / 2).round();

      final imageBytes = img.decodeImage(File(xfile.path).readAsBytesSync())!;

      img.Image editedImage;
      editedImage = img.copyCrop(
        imageBytes,
        x: offsetX,
        y: offsetY,
        width: resizedWidth,
        height: resizedHeight,
      );

      editedImage = img.copyResize(editedImage, width: 1500);

      if (needRotate) {
        int angle = 0;
        if (orientation.value == CustomOrientation.leftLandScape) {
          angle = 90;
        }
        if (orientation.value == CustomOrientation.rightLandScape) {
          angle = -90;
        }
        editedImage = img.copyRotate(editedImage, angle: angle);
      }

      File editedImageFile = await File(xfile.path).writeAsBytes(img.encodeJpg(editedImage));
      if (targetDir == null) await initTargetDir();
      savedFile = await moveFile(editedImageFile, '${targetDir!.path}/${DateTime.now().toPhotoFileName()}');
      logInfo(savedFile.path, des: 'savedFile.path');
    } catch (e) {
      logError(e, des: 'TakePicController._imageFileProcessing()');
    }
    return savedFile;
  }
}
