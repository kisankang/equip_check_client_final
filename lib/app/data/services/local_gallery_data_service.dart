// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:equip_check_client/app/data/models/deleted_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/edited_gallery_item.dart';
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:equip_check_client/app/data/models/new_gallery_picture.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalGalleryDataService extends GetxService {
  late Box<NewGalleryPicture> new_gallery_box;
  late Box<EditedGalleryItem> edited_gallery_box;
  late Box<DeletedGalleryPicture> deleted_gallery_box;

  @override
  Future<void> onInit() async {
    await Hive.initFlutter();

    Hive.registerAdapter(NewGalleryPictureAdapter());
    new_gallery_box = await Hive.openBox<NewGalleryPicture>('new_gallery_box_1_0_3');

    Hive.registerAdapter(EditedGalleryItemAdapter());
    edited_gallery_box = await Hive.openBox<EditedGalleryItem>('edited_gallery_box_1_0_3');

    Hive.registerAdapter(DeletedGalleryPictureAdapter());
    deleted_gallery_box = await Hive.openBox<DeletedGalleryPicture>('deleted_gallery_box_1_0_3');

    // await new_gallery_box.deleteFromDisk();
    // await edited_gallery_box.deleteFromDisk();
    // await deleted_gallery_box.deleteFromDisk();

    super.onInit();
  }

  List<NewGalleryPicture> get newGalleryList => new_gallery_box.values.cast<NewGalleryPicture>().toList();

  Future<void> addNewGallery(NewGalleryPicture newGallery) async => await new_gallery_box.add(newGallery);
  Future<void> updateNewGalleryWithMachineSeq({
    required String pid,
    required String machine_seq,
  }) async {
    int index = newGalleryList.indexWhere((element) => isSameSeq(element.pid, pid));
    if (index != -1) {
      NewGalleryPicture updatedNewGalelry = newGalleryList[index].copyWith(
        machine_seq: machine_seq,
      );
      await new_gallery_box.putAt(index, updatedNewGalelry);
    }
  }

  Future<void> updateNewGalleryWithNewFilePath({
    required String pid,
    required String new_file_path,
  }) async {
    int index = newGalleryList.indexWhere((element) => isSameSeq(element.pid, pid));
    if (index != -1) {
      NewGalleryPicture updatedNewGalelry = newGalleryList[index].copyWith(
        file_path: new_file_path,
      );
      await new_gallery_box.putAt(index, updatedNewGalelry);
    }
  }

  Future<void> updateNewGalleryWithResponse(GalleryItem response) async {
    int index = newGalleryList.indexWhere((element) => element.pid == response.pid);
    if (index != -1) {
      NewGalleryPicture updatedNewGalelry = newGalleryList[index].copyWith(
        seq: response.seq,
        update_time: response.update_time,
      );
      await new_gallery_box.putAt(index, updatedNewGalelry);
    }
  }

  List<NewGalleryPicture> getNewGalleryInProject(
    String project_seq, {
    bool onlyNotUpdated = true,
  }) =>
      newGalleryList.where((element) {
        if (onlyNotUpdated) {
          return element.update_time == null && isSameSeq(element.project_seq, project_seq);
        } else {
          return isSameSeq(element.project_seq, project_seq);
        }
      }).toList();

  Future<void> removeNewGallery(String gallery_seq) async =>
      await new_gallery_box.deleteAt(newGalleryList.indexWhere((element) => isSameSeq(element.seq, gallery_seq)));

  List<EditedGalleryItem> get editedGalleryList => edited_gallery_box.values.cast<EditedGalleryItem>().toList();

  Future<void> addEditedGallery(EditedGalleryItem editedGallery) async {
    int index = editedGalleryList.indexWhere((element) => isSameSeq(element.picture_seq, editedGallery.picture_seq));
    if (index != -1) {
      EditedGalleryItem updatedEditedGallery = editedGalleryList[index].copyWith(
        picture_seq: editedGallery.picture_seq,
        title: editedGallery.title,
        value: editedGallery.value,
        check_seq: editedGallery.check_seq,
        cate_seq: editedGallery.cate_seq,
        machine_seq: editedGallery.machine_seq,
        project_seq: editedGallery.project_seq,
        mid: editedGallery.mid,
        pid: editedGallery.pid,
      );
      await edited_gallery_box.putAt(index, updatedEditedGallery);
    } else {
      await edited_gallery_box.add(editedGallery);
    }
  }

  Future<void> updateEditedGalleryWithMachineSeq({
    required String pid,
    required String machine_seq,
  }) async {
    int index = editedGalleryList.indexWhere((element) => isSameSeq(element.pid, pid));
    if (index != -1) {
      EditedGalleryItem editedGallery = editedGalleryList[index].copyWith(
        machine_seq: machine_seq,
      );
      await edited_gallery_box.putAt(index, editedGallery);
    }
  }

  Future<void> updateEditedGalleryWithNewSeq({
    required String pid,
    required String seq,
  }) async {
    int index = editedGalleryList.indexWhere((element) => isSameSeq(element.pid, pid));
    if (index != -1) {
      EditedGalleryItem editedGallery = editedGalleryList[index].copyWith(
        picture_seq: seq,
      );
      await edited_gallery_box.putAt(index, editedGallery);
    }
  }

  EditedGalleryItem? getEditedGallery(String pid) =>
      editedGalleryList.singleWhereOrNull((element) => isSameSeq(element.pid, pid));
  List<EditedGalleryItem> getEditedGalleryInProject(String project_seq) =>
      editedGalleryList.where((element) => isSameSeq(element.project_seq, project_seq)).toList();

  Future<void> removeEditedGallery(String pid) async =>
      await edited_gallery_box.deleteAt(editedGalleryList.indexWhere((element) => isSameSeq(element.pid, pid)));

  List<DeletedGalleryPicture> get deletedGalleryList =>
      deleted_gallery_box.values.cast<DeletedGalleryPicture>().toList();

  Future<void> addDeletedGallery(DeletedGalleryPicture deletedGallery) async =>
      await deleted_gallery_box.add(deletedGallery);

  Future<void> updateDeletedGalleryWithMachineSeq({
    required String pid,
    required String machine_seq,
  }) async {
    int index = deletedGalleryList.indexWhere((element) => isSameSeq(element.pid, pid));
    if (index != -1) {
      DeletedGalleryPicture deletedGallery = deletedGalleryList[index].copyWith(
        machine_seq: machine_seq,
      );
      await deleted_gallery_box.putAt(index, deletedGallery);
    }
  }

  Future<void> updateDeletedGalleryWithNewSeq({
    required String pid,
    required String seq,
  }) async {
    int index = deletedGalleryList.indexWhere((element) => isSameSeq(element.pid, pid));
    if (index != -1) {
      DeletedGalleryPicture deletedGallery = deletedGalleryList[index].copyWith(
        seq: seq,
      );
      await deleted_gallery_box.putAt(index, deletedGallery);
    }
  }

  DeletedGalleryPicture? getDeletedGallery(String pid) =>
      deletedGalleryList.singleWhereOrNull((element) => isSameSeq(element.pid, pid));
  List<DeletedGalleryPicture> getDeletedGalleryInProject(String project_seq) =>
      deletedGalleryList.where((element) => isSameSeq(element.project_seq, project_seq)).toList();

  Future<void> removeDeletedGallery(String pid) async =>
      await deleted_gallery_box.deleteAt(deletedGalleryList.indexWhere((element) => isSameSeq(element.pid, pid)));
}
