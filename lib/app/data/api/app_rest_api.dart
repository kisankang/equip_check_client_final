import 'package:dio/dio.dart';
import 'package:equip_check_client/app/data/models/base_response.dart';
import 'package:retrofit/retrofit.dart';

part 'app_rest_api.g.dart';

@RestApi()
abstract class AppRestAPI {
  factory AppRestAPI(Dio dio, {String baseUrl}) = _AppRestAPI;

  @GET("/init")
  Future<BaseResponse?> init();

  @POST("/signin")
  Future<BaseResponse?> signIn(@Queries() Map<String, dynamic> queries);

  @POST("/find_pw")
  Future<BaseResponse?> findPw(@Queries() Map<String, dynamic> queries);

  @POST("/machine_project_list")
  Future<BaseResponse?> getProjectList(@Queries() Map<String, dynamic> queries);

  @POST("/machine_list")
  Future<BaseResponse?> getMachineList(@Queries() Map<String, dynamic> queries);

  @POST("/machine_info")
  Future<BaseResponse?> getMachine(@Queries() Map<String, dynamic> queries);

  @POST("/machine_add")
  Future<BaseResponse?> addMachine(@Queries() Map<String, dynamic> queries);

  @POST("/machine_delete")
  Future<BaseResponse?> deleteMachine(@Queries() Map<String, dynamic> queries);

  @POST("/machine_update")
  Future<BaseResponse?> editMachine(@Queries() Map<String, dynamic> queries);

  @POST("/upload/machine/gallery_picture")
  Future<BaseResponse?> uploadNewGallery(@Body() FormData data);

  @POST("/machine_picture_update")
  Future<BaseResponse?> editGallery(@Queries() Map<String, dynamic> queries);

  @POST("/machine_picture_delete")
  Future<BaseResponse?> deleteGallery(@Queries() Map<String, dynamic> queries);

  @POST("/machine_submit_complete")
  Future<BaseResponse?> submitCompleted(@Queries() Map<String, dynamic> queries);
}
