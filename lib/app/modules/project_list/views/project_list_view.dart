import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/widgets/project_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/project_list_controller.dart';

class ProjectListView extends GetView<ProjectListController> {
  const ProjectListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        title: const Text(
          '현장 목록',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              focusNode: controller.searchFocusNode,
              controller: controller.searchController,
              onEditingComplete: controller.onSearch,
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: GestureDetector(
                  onTap: controller.onSearch,
                  child: const Icon(Icons.search),
                ),
                suffixIconColor: AppColors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                List<Project> projectList = controller.projectList.value;
                List<bool?> updateCheckList = controller.needUpdateCheckList.value;

                // if (controller.isSearchResultExist.value == null) {
                //   return const Center(
                //     child: Text("현장 이름을 검색해주세요."),
                //   );
                // }

                if (controller.isSearchResultExist.value == false) {
                  return Center(
                    child: Text("'${controller.searchController.text}' 검색 결과가 없습니다."),
                  );
                }

                return ListView.builder(
                  itemCount: projectList.length,
                  itemBuilder: (context, index) {
                    Project project = projectList[index];
                    bool? needUpdate;
                    if (updateCheckList.isNotEmpty) {
                      needUpdate = updateCheckList[index];
                    }
                    return ProjectItem(
                      needUpdate: needUpdate,
                      onTap: () => controller.onTapProjectItem(project.seq),
                      imageUrl: project.picture,
                      name: project.name,
                      bgnDt: project.bgnDt,
                      endDt: project.endDt,
                      dris: project.engineer_names,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
