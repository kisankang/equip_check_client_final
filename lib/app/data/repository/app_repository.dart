// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:equip_check_client/app/data/api/app_api.dart';
import 'package:equip_check_client/app/data/models/base_response.dart';
import 'package:equip_check_client/app/data/models/edited_gallery_item.dart';
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/data/models/new_machine.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/data/models/new_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/edited_machine.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/utils/log.dart';

class AppRepository {
  AppRepository({required AppAPI appAPI}) : _appAPI = appAPI;
  final AppAPI _appAPI;

  Future<BaseResponse?> init() async {
    BaseResponse? response;
    try {
      response = await _appAPI.client.init();
    } catch (err) {
      logError(err, des: 'AppRepository.init()');
    }
    return response;
  }

  Future<BaseResponse?> signIn({
    required String email,
    required String password,
  }) async {
    String sha1Pw = sha1Encode(password);
    BaseResponse? response;
    try {
      Map<String, dynamic> body = {
        "email": email,
        "passwd": sha1Pw,
      };
      response = await _appAPI.client.signIn(body);
    } catch (err) {
      logError(err, des: 'AppRepository.signIn(email:$email)');
    }
    return response;
  }

  Future<String?> findPw({
    required String email,
  }) async {
    String? result;
    try {
      Map<String, dynamic> body = {
        "email": email,
      };
      BaseResponse? response = await _appAPI.client.findPw(body);
      result = response?.result?.message;
    } catch (err) {
      logError(err, des: 'AppRepository.findPw(email:$email)');
    }
    return result;
  }

  Future<List<Project>?> getProjectList({required String user_seq, String? q}) async {
    List<Project>? result;
    try {
      Map<String, dynamic> body = {
        "user_seq": user_seq,
      };
      if (q != null) {
        body.addAll({"q": q});
      }
      BaseResponse? response = await _appAPI.client.getProjectList(body);
      result = (response?.data as List).map((e) => Project.fromJson(e)).toList();
    } catch (err) {
      logError(err, des: 'AppRepository.getProjectList(user_seq:$user_seq)');
    }
    return result;
  }

  Future<List<Machine>?> getMachineList({required String project_seq}) async {
    List<Machine>? result;
    try {
      Map<String, dynamic> body = {
        "project_seq": project_seq,
      };
      BaseResponse? response = await _appAPI.client.getMachineList(body);
      result = (response?.data as List).map((e) => Machine.fromJson(e)).toList();
    } catch (err) {
      logError(err, des: 'AppRepository.getMachineList(project_seq:$project_seq)');
    }
    return result;
  }

  Future<Machine?> getMachine({required String machine_seq}) async {
    Machine? result;
    try {
      Map<String, dynamic> body = {
        "seq": machine_seq,
      };
      BaseResponse? response = await _appAPI.client.getMachine(body);
      result = Machine.fromJson(response?.data);
    } catch (err) {
      logError(err, des: 'AppRepository.getMachine(machine_seq:$machine_seq)');
    }
    return result;
  }

  Future<BaseResponse?> addMachine({
    required NewMachine newMachine,
  }) async {
    assert(newMachine.qty == 1);
    BaseResponse? result;
    try {
      Map<String, dynamic> body = {
        "project_seq": newMachine.project_seq,
        "cate1": newMachine.cate1,
        "cate2": newMachine.cate2,
        "qty": newMachine.qty,
        "mid": newMachine.mid,
      };
      result = await _appAPI.client.addMachine(body);
    } catch (err) {
      logError(err, des: 'AppRepository.addMachine(project_seq:${newMachine.project_seq})');
    }
    return result;
  }

  Future<BaseResponse?> editMachine({
    required EditedMachine editedMachine,
  }) async {
    BaseResponse? result;
    try {
      Map<String, dynamic> body = editedMachine.toJson();
      result = await _appAPI.client.editMachine(body);
    } catch (err) {
      logError(err, des: 'AppRepository.editMachine(mid:${editedMachine.mid})');
    }
    return result;
  }

  Future<BaseResponse?> deleteMachine({
    required String mid,
  }) async {
    BaseResponse? result;
    try {
      Map<String, dynamic> body = {
        "mid": mid,
      };
      result = await _appAPI.client.deleteMachine(body);
    } catch (err) {
      logError(err, des: 'AppRepository.deleteMachine(mid:$mid)');
    }
    return result;
  }

  Future<BaseResponse?> uploadNewGallery({
    required NewGalleryPicture newGallery,
  }) async {
    BaseResponse? result;
    try {
      Map<String, dynamic> data = newGallery.toJson();
      data['userfile'] = await MultipartFile.fromFile(newGallery.file_path!, filename: newGallery.file_name);
      FormData formData = FormData.fromMap(data);

      result = await _appAPI.client.uploadNewGallery(formData);
    } catch (err) {
      logError(err, des: 'AppRepository.uploadNewGallery(machine_seq:${newGallery.machine_seq})');
    }
    return result;
  }

  Future<BaseResponse?> editGallery({
    required EditedGalleryItem editedGalleryItem,
  }) async {
    BaseResponse? result;
    try {
      Map<String, dynamic> body = editedGalleryItem.toJson();
      result = await _appAPI.client.editGallery(body);
    } catch (err) {
      logError(err, des: 'AppRepository.editGallery(machine_seq:${editedGalleryItem.picture_seq})');
    }
    return result;
  }

  Future<BaseResponse?> deleteGallery({
    required String pid,
  }) async {
    BaseResponse? result;
    try {
      Map<String, dynamic> body = {
        "pid": pid,
      };
      result = await _appAPI.client.deleteGallery(body);
    } catch (err) {
      logError(err, des: 'AppRepository.deleteGallery(pid:$pid)');
    }
    return result;
  }

  Future<Project?> submitCompleted({
    required String project_seq,
  }) async {
    Project? result;
    try {
      Map<String, dynamic> body = {
        'project_seq': project_seq,
      };
      BaseResponse? response = await _appAPI.client.submitCompleted(body);
      if (response != null) {
        result = Project.fromJson(response.data);
      }
    } catch (err) {
      logError(err, des: 'AppRepository.submitCompleted(project_seq:$project_seq)');
    }
    return result;
  }
}
