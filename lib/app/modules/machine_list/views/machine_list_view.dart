// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/modules/machine_list/views/machine_item.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/machine_list_controller.dart';

class MachineListView extends GetView<MachineListController> {
  const MachineListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        title: Obx(
          () => Text(
            '설비목록 (${controller.machine_list.length})',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.onTapAddMachine,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
              child: Obx(
                () {
                  Project? project = controller.project.value;
                  return Table(
                    border: TableBorder.all(color: Colors.black, width: 1.5),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                    },
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: Colors.white),
                        children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
                              child: Text('현장명'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
                            child: Text(
                              project?.name ?? '-',
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: const BoxDecoration(color: Colors.white),
                        children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
                              child: Text('점검기간'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
                            child: Text(periodConverter(bgnDt: project?.bgnDt, endDt: project?.endDt)),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Obx(() {
                List<Machine> machine_list = controller.machine_list;
                return ListView.builder(
                  itemCount: machine_list.length,
                  itemBuilder: (context, index) {
                    Machine machine = machine_list[index];
                    String galleryCount = ' (${machine.gallery?.length.toString() ?? '0'})';
                    String name = (machine.name ?? '') + galleryCount;
                    return MachineItem(
                      onTap: () => controller.onTapMachineItem(machine.mid),
                      onTapConfirmToDelete: controller.isDeletable(index)
                          ? () => controller.onTapConfirmToDeleteMachine(
                                machine_seq: machine.seq,
                                mid: machine.mid,
                              )
                          : null,
                      imageUrl: machine.picture,
                      name: name,
                      period: machine.check_date,
                      location: machine.location,
                      dri: machine.engineer1_name,
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
