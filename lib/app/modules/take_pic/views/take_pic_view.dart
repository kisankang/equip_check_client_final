import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/data/models/picture_cate_item.dart';
import 'package:equip_check_client/app/widgets/custom_dropdown_button.dart';
import 'package:equip_check_client/app/widgets/custom_orientation_builder.dart';
import 'package:equip_check_client/app/widgets/photo_viewer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/take_pic_controller.dart';

class TakePicView extends GetView<TakePicController> {
  const TakePicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.machine.name ?? '-',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => controller.isInitializedCamera.value
                  ? CameraPreview(controller.cameraController)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          Positioned.fill(
            child: CustomOrientationBuilder(
              isVideosRecording: false,
              builder: (context, orientation) {
                return Obx(() {
                  bool isPortrait = orientation == CustomOrientation.portrait;
                  if (controller.orientation.value != orientation) {
                    controller.orientation.value = orientation;
                  }
                  return Column(
                    children: [
                      _renderCateSelect(isPortrait),
                      Obx(
                        () => Container(
                          width: Get.size.width,
                          height: controller.cameraHeight(isPortrait),
                          color: controller.blink.value ? Colors.black : Colors.transparent,
                        ),
                      ),
                      _renderTakeShoot()
                    ],
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded _renderCateSelect(bool isPortrait) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: CustomDropdownButton(
            list: controller.checkList.map((e) => e.name).toList(),
            countList: controller.checkListItemCountList,
            selectedValue: controller.selectedCheckListItemName,
            isOutlined: false,
            alignment: AlignmentDirectional.center,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Obx(() {
            List<PictureCateItem?>? pictureCateList = controller.pictureCateList;
            Rx<String?> selectedPictureCateItemName = controller.selectedPictureCateItemName;
            return CustomDropdownButton(
              list: pictureCateList?.map((e) => e?.name).toList(),
              countList: controller.pictureCateCountList,
              selectedValue: selectedPictureCateItemName,
              isOutlined: false,
              alignment: AlignmentDirectional.center,
            );
          }),
        ),
      ],
    );
    if (!isPortrait) {
      content = SingleChildScrollView(child: content);
    }
    return Expanded(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: content,
        ),
      ),
    );
  }

  Expanded _renderTakeShoot() {
    return Expanded(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Obx(() {
                  String? imagePath = controller.photos.value.lastOrNull?.path;
                  if (imagePath == null) {
                    return const SizedBox();
                  }
                  return GestureDetector(
                    onTap: () => Get.to(() => Scaffold(
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            centerTitle: true,
                            title: Obx(
                              () => Text(
                                controller.selectedPictureCateItemName.value ??
                                    controller.selectedCheckListItemName.value ??
                                    '',
                              ),
                            ),
                            actions: [
                              IconButton(
                                onPressed: Get.back,
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          body: PhotoViewer(
                            imagePath: imagePath,
                          ),
                        )),
                    child: Image.file(
                      width: 48,
                      height: 48,
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ),
            Container(
                width: 92,
                height: 92,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue,
                ),
                child: Obx(() => IconButton(
                      onPressed: controller.isInitializedCamera.value && !controller.isTakingPhoto.value
                          ? controller.onTapTakePhoto
                          : null,
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 56,
                      ),
                    ))),
            IconButton(
              onPressed: controller.onTapFlash,
              icon: Obx(
                () {
                  IconData iconData = controller.flashMode.value == FlashMode.off ? Icons.flash_off : Icons.flash_on;
                  return Icon(
                    iconData,
                    size: 24,
                    color: Colors.yellowAccent,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
