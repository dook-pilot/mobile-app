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
  @POST("/license-plate/")
  Future<CarDetailsResponse> carDetailsRequest(@Part() File file, @Part() String lat, @Part() String lng);

  @GET("/rdw/{id}/?format=json")
  Future<LicenseDetailsResponse> getLicenseDetail(@Path("id") String id);
}
