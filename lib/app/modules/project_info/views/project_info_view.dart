import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/widgets/project_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/project_info_controller.dart';

class ProjectInfoView extends GetView<ProjectInfoController> {
  const ProjectInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        title: const Text(
          '현장정보',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilledButton(
            onPressed: controller.onTapMachineList,
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: AppColors.blue,
            ),
            child: const Text(
              '설비목록',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProjectItem(
                imageUrl: controller.project.value.picture,
                name: controller.project.value.name,
                bgnDt: controller.project.value.bgnDt,
                endDt: controller.project.value.endDt,
                dris: controller.project.value.engineer_names,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => FilledButton(
                    onPressed: controller.isActiveUpdateButton.value ? controller.onTapSendDataToServer : null,
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.blue,
                    ),
                    child: const Text('서버로 데이터 보내기'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Obx(() => TextButton(
                      onPressed: controller.isActiveDeleteLocalButton.value ? controller.onTapDeleteLocalData : null,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '로컬 데이터 삭제',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
              Obx(() {
                Project project = controller.project.value;
                return Text('마지막 전송일시: ${project.app_submit_time ?? '없음'}');
              }),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('관리주체 요청사항'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(controller.project.value.requirement),
                  ),
                  const SizedBox(height: 16),
                  const Text('특이사항'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(controller.project.value.note),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
