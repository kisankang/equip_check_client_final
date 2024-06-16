// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:equip_check_client/app/data/models/base_response.dart';
import 'package:equip_check_client/app/data/models/deleted_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/deleted_machine.dart';
import 'package:equip_check_client/app/data/models/edited_gallery_item.dart';
import 'package:equip_check_client/app/data/models/edited_machine.dart';
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/data/models/machine_cate.dart';
import 'package:equip_check_client/app/data/models/machine_cate_tree.dart';
import 'package:equip_check_client/app/data/models/new_machine.dart';
import 'package:equip_check_client/app/data/models/sign_in_response.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/data/models/new_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/user.dart';
import 'package:equip_check_client/app/data/repository/app_repository.dart';
import 'package:equip_check_client/app/data/services/local_app_data_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/utils/log.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  final AppRepository _appRepository;
  final LocalAppDataService _localAppDataService;
  final LocalGalleryDataService _localGalleryDataService;
  final LocalMachineDataService _localMachineDataService;
  AppService({
    required AppRepository appRepository,
    required LocalAppDataService localAppDataService,
    required LocalGalleryDataService localGalleryDataService,
    required LocalMachineDataService localMachineDataService,
  })  : _appRepository = appRepository,
        _localAppDataService = localAppDataService,
        _localGalleryDataService = localGalleryDataService,
        _localMachineDataService = localMachineDataService;

  Future<BaseResponse?> init() async {
    BaseResponse? response = await _appRepository.init();
    return response;
  }

  late User user;
  late List<MachineCate> machine_cate_list;
  late List<MachineCateTree> machine_cate_tree;
  late List<String> unit_list;

  initOfflineMode() {
    User? userData = _localAppDataService.getLastLoggedInUser();
    if (userData == null) {
      return EasyLoading.showError('인터넷 사용한 가능한 곳에서 최초 1회 로그인 하셔야합니다.');
    }
    user = userData;
    projectList.value = _localAppDataService.getLastLogginedUserProjects()!;
    machine_cate_list = _localAppDataService.getMachineCateList()!;
    unit_list = _localAppDataService.getUnitList()!;
    for (Project project in projectList.value) {
      machineList.update((val) {
        val?[project.seq!] = _localAppDataService.getMachinesInProject(project.seq!)!;
      });
      reflectAllChangesInProject(project.seq!);
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    String? result;
    SignInResponse? response;
    BaseResponse? baseResponse = await _appRepository.signIn(
      email: email,
      password: password,
    );
    if (baseResponse?.result?.code != 100) {
      result = baseResponse?.result?.message;
    } else {
      response = SignInResponse(
        user: User.fromJson(baseResponse?.data?['user']),
        machine_cate_list:
            (baseResponse?.data?['machine_cate_list'] as List).map((e) => MachineCate.fromJson(e)).toList(),
        machine_cate_tree:
            (baseResponse?.data?['machine_cate_tree'] as List).map((e) => MachineCateTree.fromJson(e)).toList(),
        unit_List: (baseResponse?.data?['unit_list'] as List).map((e) => e as String).toList(),
      );
      if (response.user != null) {
        user = response.user!;
        await _localAppDataService.writeLastUpdatedUser(user);
        logSuccess(user.toJson(), des: 'AppService.signIn()');
      }
      if (response.machine_cate_list != null) {
        machine_cate_list = response.machine_cate_list!;
        await _localAppDataService.putMachineCateList(machine_cate_list);
      }
      if (response.machine_cate_tree != null) {
        machine_cate_tree = response.machine_cate_tree!;
        await _localAppDataService.putMachineCateTree(machine_cate_tree);
      }
      if (response.unit_List != null) {
        unit_list = response.unit_List!;
        await _localAppDataService.putMachineCateTree(machine_cate_tree);
      }
    }
    return result;
  }

  Future<String?> findPw({
    required String email,
  }) async {
    String? result;
    result = await _appRepository.findPw(email: email);
    return result;
  }

  Rx<List<Project>> projectList = Rx([]);
  Future<List<Project>?> getProjectList({
    String? q,
  }) async {
    List<Project>? result = await _appRepository.getProjectList(
      user_seq: user.seq,
      q: q,
    );
    projectList.value = result ?? [];
    for (Project prj in projectList.value) {
      await _localAppDataService.putProject(prj);
    }
    return result;
  }

  Rx<Map<String, List<Machine>>> machineList = Rx({});
  Future<List<Machine>?> fetchMachineList({
    required String project_seq,
  }) async {
    List<Machine>? result = await _appRepository.getMachineList(
      project_seq: project_seq,
    );
    if (result != null) {
      machineList.update((val) {
        val?[project_seq] = result;
      });
      await _localAppDataService.putMachines(result);
    }

    return result;
  }

  Future<int> updateNewMachine({
    required String project_seq,
    required int currentCount,
    required int totalCount,
  }) async {
    List<NewMachine> new_machine_list = _localMachineDataService.getNewMachineInProject(project_seq);
    if (new_machine_list.isEmpty) return 0;

    for (NewMachine newMachine in new_machine_list) {
      BaseResponse? response = await _appRepository.addMachine(newMachine: newMachine);
      if (response?.result?.code != 100) {
        logError(response?.result?.message, des: 'AppService.updateNewMachine(mid:${newMachine.mid})');
      } else {
        currentCount++;
        await EasyLoading.showProgress(
          currentCount / totalCount,
          status: '서버 전송중...\n$currentCount/$totalCount',
          maskType: EasyLoadingMaskType.black,
        );
        List<Machine> machinesFromResponse = (response?.data as List).map((e) => Machine.fromJson(e)).toList();
        await _localMachineDataService.removeNewMachine(newMachine.mid);
        Machine machineFromResponse = machinesFromResponse.first;
        int? machineIndex = machineList.value[machineFromResponse.project_seq]
            ?.indexWhere((element) => isSameSeq(element.mid, newMachine.mid));
        if (machineIndex != null && machineIndex != -1) {
          machineList.update((val) {
            val?[machineFromResponse.project_seq]?[machineIndex] =
                val[machineFromResponse.project_seq]![machineIndex].copyWithOtherMachine(machineFromResponse);
          });
          if (machineList.value[machineFromResponse.project_seq]?[machineIndex].gallery != null) {
            for (int galleryIndex = 0;
                galleryIndex < machineList.value[machineFromResponse.project_seq]![machineIndex].gallery!.length;
                galleryIndex++) {
              machineList.update((val) {
                val?[machineFromResponse.project_seq]?[machineIndex].gallery?[galleryIndex] =
                    val[machineFromResponse.project_seq]![machineIndex]
                        .gallery![galleryIndex]
                        .copyWith(machine_seq: machineFromResponse.seq);
              });
              GalleryItem galleryItem =
                  machineList.value[machineFromResponse.project_seq]![machineIndex].gallery![galleryIndex];
              await _localGalleryDataService.updateNewGalleryWithMachineSeq(
                  pid: galleryItem.pid, machine_seq: machineFromResponse.seq);
              await _localGalleryDataService.updateEditedGalleryWithMachineSeq(
                  pid: galleryItem.pid, machine_seq: machineFromResponse.seq);
              await _localGalleryDataService.updateDeletedGalleryWithMachineSeq(
                  pid: galleryItem.pid, machine_seq: machineFromResponse.seq);
            }
          }
        }
        EditedMachine? editedMachine = _localMachineDataService.getEditedMachine(newMachine.mid);
        if (editedMachine != null) {
          await _localMachineDataService.updateEditedMachineWithNewSeq(
              mid: newMachine.mid, machine_seq: machineFromResponse.seq);
          reflectMachineChanges(editedMachine.toMachine(new_seq: machineFromResponse.seq));
        }
        DeletedMachine? deletedMachine = _localMachineDataService.getDeletedMachine(newMachine.mid);
        if (deletedMachine != null) {
          await _localMachineDataService.updateDeletedMachineWithNewSeq(
              mid: newMachine.mid, machine_seq: machineFromResponse.seq);
          reflectMachineChanges(deletedMachine.toMachine(new_seq: machineFromResponse.seq));
        }
      }
    }
    return currentCount;
  }

  Future<int> updateEditedMachine({
    required String project_seq,
    required int currentCount,
    required int totalCount,
  }) async {
    List<EditedMachine> edited_machine_list = _localMachineDataService.getEditedMachineInProject(project_seq);
    if (edited_machine_list.isEmpty) return 0;

    for (EditedMachine editedMachine in edited_machine_list) {
      BaseResponse? response = await _appRepository.editMachine(editedMachine: editedMachine);
      if (response?.result?.code != 100) {
        logError(response?.result?.message, des: 'AppService.updateEditedMachine(mid:${editedMachine.mid})');
      } else {
        currentCount++;
        await EasyLoading.showProgress(
          currentCount / totalCount,
          status: '서버 전송중...\n$currentCount/$totalCount',
          maskType: EasyLoadingMaskType.black,
        );
        await _localMachineDataService.removeEditedMachine(editedMachine.mid);
      }
    }
    return totalCount;
  }

  Future<int> updateDeletedMachine({
    required String project_seq,
    required int currentCount,
    required int totalCount,
  }) async {
    List<DeletedMachine> deleted_machine_list = _localMachineDataService.getDeletedMachineInProject(project_seq);
    if (deleted_machine_list.isEmpty) return 0;

    for (DeletedMachine deletedMachine in deleted_machine_list) {
      BaseResponse? response = await _appRepository.deleteMachine(
        mid: deletedMachine.mid,
      );
      if (response?.result?.code != 100) {
        logError(response?.result?.message, des: 'AppService.updateDeletedMachine(mid:${deletedMachine.mid})');
      } else {
        currentCount++;
        await EasyLoading.showProgress(
          currentCount / totalCount,
          status: '서버 전송중...\n$currentCount/$totalCount',
          maskType: EasyLoadingMaskType.black,
        );
        await _localMachineDataService.removeDeletedMachine(deletedMachine.mid);
      }
    }
    return currentCount;
  }

  Future<int> updateNewGallery({
    required String project_seq,
    required int currentCount,
    required int totalCount,
  }) async {
    List<NewGalleryPicture> new_gallery_list = _localGalleryDataService.getNewGalleryInProject(project_seq);
    if (new_gallery_list.isEmpty) return 0;

    for (NewGalleryPicture newGallery in new_gallery_list) {
      BaseResponse? response = await _appRepository.uploadNewGallery(newGallery: newGallery);
      if (response?.result?.code != 100) {
        logError(response?.result?.message, des: 'AppService.updateNewGallery(pid:${newGallery.pid})');
      } else {
        currentCount++;
        await EasyLoading.showProgress(
          currentCount / totalCount,
          status: '서버 전송중...\n$currentCount/$totalCount',
          maskType: EasyLoadingMaskType.black,
        );
        GalleryItem galleryFromResponse = GalleryItem.fromJson(response?.data);
        int? machineIndex =
            machineList.value[project_seq]?.indexWhere((element) => isSameSeq(element.mid, galleryFromResponse.mid));
        if (machineIndex != null && machineIndex != -1) {
          int? galleryIndex = machineList.value[project_seq]?[machineIndex].gallery
              ?.indexWhere((element) => isSameSeq(element.pid, newGallery.pid));
          if (galleryIndex != null && galleryIndex != -1) {
            machineList.update((val) {
              val?[project_seq]?[machineIndex].gallery?[galleryIndex] =
                  val[project_seq]![machineIndex].gallery![galleryIndex].copyWithOtherGallery(galleryFromResponse);
            });
          }
        }
        await _localGalleryDataService.updateNewGalleryWithResponse(galleryFromResponse);
        EditedGalleryItem? editedGallery = _localGalleryDataService.getEditedGallery(newGallery.pid);
        if (editedGallery != null) {
          await _localGalleryDataService.updateEditedGalleryWithNewSeq(
              pid: newGallery.pid, seq: galleryFromResponse.seq!);
          reflectGalleryChanges(editedGallery.toGalleryItem(new_seq: galleryFromResponse.seq));
        }
        DeletedGalleryPicture? deletedGallery = _localGalleryDataService.getDeletedGallery(newGallery.pid);
        if (deletedGallery != null) {
          await _localGalleryDataService.updateDeletedGalleryWithNewSeq(
              pid: newGallery.pid, seq: galleryFromResponse.seq!);
          reflectGalleryChanges(deletedGallery.toGalleryItem(new_seq: galleryFromResponse.seq));
        }
      }
    }
    return currentCount;
  }

  Future<int> updateEditedGallery({
    required String project_seq,
    required int currentCount,
    required int totalCount,
  }) async {
    List<EditedGalleryItem>? edited_gallery_list = _localGalleryDataService.getEditedGalleryInProject(project_seq);
    if (edited_gallery_list.isEmpty) return 0;

    for (EditedGalleryItem editedGallery in edited_gallery_list) {
      BaseResponse? response = await _appRepository.editGallery(editedGalleryItem: editedGallery);
      if (response?.result?.code != 100) {
        logError(response?.result?.message, des: 'AppService.updateEditedGallery(pid:${editedGallery.pid})');
      } else {
        currentCount++;
        await EasyLoading.showProgress(
          currentCount / totalCount,
          status: '서버 전송중...\n$currentCount/$totalCount',
          maskType: EasyLoadingMaskType.black,
        );
        GalleryItem galleryFromResponse = GalleryItem.fromJson(response?.data);
        await _localGalleryDataService.removeEditedGallery(galleryFromResponse.pid);
      }
    }
    return currentCount;
  }

  Future<int> updateDeletedGallery({
    required String project_seq,
    required int currentCount,
    required int totalCount,
  }) async {
    List<DeletedGalleryPicture> deleted_gallery_seq_list =
        _localGalleryDataService.getDeletedGalleryInProject(project_seq);
    if (deleted_gallery_seq_list.isEmpty) return 0;

    for (DeletedGalleryPicture deletedGallery in deleted_gallery_seq_list) {
      BaseResponse? response = await _appRepository.deleteGallery(pid: deletedGallery.pid);
      if (response?.result?.code != 100) {
        logError(response?.result?.message, des: 'AppService.updateDeletedGallery(pid:${deletedGallery.pid})');
      } else {
        currentCount++;
        await EasyLoading.showProgress(
          currentCount / totalCount,
          status: '서버 전송중...\n$currentCount/$totalCount',
          maskType: EasyLoadingMaskType.black,
        );
        await _localGalleryDataService.removeDeletedGallery(deletedGallery.pid);
      }
    }
    return currentCount;
  }

  Future<void> updateCompleted(String project_seq) async {
    Project? project = await _appRepository.submitCompleted(project_seq: project_seq);
    if (project != null) {
      int index = projectList.value.indexWhere((element) => isSameSeq(element.seq, project.seq));
      if (index != -1) {
        projectList.update((val) {
          val?[index] = val[index].copyWithAppSubmitTime(project.app_submit_time);
        });
      }
    }
    logInfo(project?.toJson(), des: 'AppService.updateCompleted($project_seq)');
  }

  void reflectGalleryChanges(GalleryItem galleryItem, {bool isDeleting = false}) {
    List<String> projectKeyList = machineList.value.keys.toList();
    for (int projectKeyIndex = 0; projectKeyIndex < projectKeyList.length; projectKeyIndex++) {
      String project_seq = projectKeyList[projectKeyIndex];
      List<Machine>? machine_list = machineList.value[project_seq];
      if (machine_list != null) {
        for (int machineIndex = 0; machineIndex < machine_list.length; machineIndex++) {
          if (isSameSeq(machine_list[machineIndex].mid, galleryItem.mid)) {
            List<GalleryItem>? galleryList = machine_list[machineIndex].gallery;
            if (galleryList == null) {
              // add new into empty
              return machineList.update((val) {
                val?[project_seq]?[machineIndex].gallery = [galleryItem];
              });
            } else {
              int galleryIndex = galleryList.indexWhere((element) => isSameSeq(element.pid, galleryItem.pid));
              if (galleryIndex == -1) {
                // add new into current
                return machineList.update((val) {
                  val?[project_seq]?[machineIndex].gallery!.add(galleryItem);
                });
              } else {
                if (!isDeleting) {
                  // update edited
                  return machineList.update((val) {
                    val?[project_seq]?[machineIndex].gallery![galleryIndex] =
                        val[project_seq]![machineIndex].gallery![galleryIndex].copyWithOtherGallery(galleryItem);
                  });
                } else {
                  // delete
                  return machineList.update((val) {
                    val?[project_seq]?[machineIndex].gallery?.removeAt(galleryIndex);
                  });
                }
              }
            }
          }
        }
      }
    }
  }

  void reflectMachineChanges(Machine machine, {bool isDeleting = false}) {
    List<String> projectKeyList = machineList.value.keys.toList();
    String project_seq = projectKeyList.singleWhere((element) => element == machine.project_seq);
    List<Machine>? machine_list = machineList.value[project_seq];

    if (machine_list != null) {
      int index = machine_list.indexWhere((element) => isSameSeq(element.mid, machine.mid));
      if (index == -1) {
        machine.name ??=
            machine_cate_list.singleWhereOrNull((element) => isSameSeq(machine.cate_seq, element.seq))?.name;
        if (machine_list.isEmpty) {
          // add into Empty
          return machineList.update((val) {
            val?[project_seq] = [machine];
          });
        } else {
          // add into current
          return machineList.update((val) {
            val?[project_seq]?.add(machine);
          });
        }
      } else {
        // update edited
        if (!isDeleting) {
          return machineList.update((val) {
            val?[project_seq]?[index] = val[project_seq]![index].copyWithOtherMachine(machine);
          });
        } else {
          // delete
          return machineList.update((val) {
            val?[project_seq]?.removeAt(index);
          });
        }
      }
    }
  }

  void reflectAllChangesInProject(String project_seq) {
    List<NewMachine> newMachine = _localMachineDataService.getNewMachineInProject(project_seq);
    for (var element in newMachine) {
      reflectMachineChanges(element.toMachine());
    }
    List<EditedMachine> editedMachine = _localMachineDataService.getEditedMachineInProject(project_seq);
    for (var element in editedMachine) {
      reflectMachineChanges(element.toMachine());
    }
    List<DeletedMachine> deletedMachine = _localMachineDataService.getDeletedMachineInProject(project_seq);
    for (var element in deletedMachine) {
      reflectMachineChanges(element.toMachine(), isDeleting: true);
    }

    List<NewGalleryPicture> newGallery = _localGalleryDataService.getNewGalleryInProject(project_seq);
    for (var element in newGallery) {
      reflectGalleryChanges(element.toGalleryItem());
    }
    List<EditedGalleryItem> editedGallery = _localGalleryDataService.getEditedGalleryInProject(project_seq);
    for (var element in editedGallery) {
      reflectGalleryChanges(element.toGalleryItem());
    }
    List<DeletedGalleryPicture> deletedGallery = _localGalleryDataService.getDeletedGalleryInProject(project_seq);
    for (var element in deletedGallery) {
      reflectGalleryChanges(element.toGalleryItem(), isDeleting: true);
    }
  }
}
