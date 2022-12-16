import 'dart:io';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:vng_pilot/configs/configs.dart';
import 'models.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: "")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    return ApiService(dio, baseUrl: HOST_URL);
  }

  @MultiPart()
  @POST("/upload/")
  Future<FileUploadResponse> uploadFile(@Part() File file, @Part() String title, @Part() String user_id);

  @GET("/get-history/{user_id}")
  Future<HistoryResponse> getHistory(@Path("user_id") String user_id);

  @GET("/get-data/{id}")
  Future<CarDetailsResponse> getLicenseDetails(@Path("id") String id);

  @MultiPart()
  @POST("/license-plate/")
  Future<CarDetailsResponse> carDetailsRequest(@Part() File file);

  // @GET("/rdw/{id}/?format=json")
  // Future<LicenseDetailsResponse> getLicenseDetail(@Path("id") String id);

  @MultiPart()
  @POST("temp.php")
  Future<String> temp(@Part() File image);
}
