import 'dart:io';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'models.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: "")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create({required String baseUrl}) {
    final dio = Dio();
    return ApiService(dio, baseUrl: baseUrl);
  }

  @POST("/vngp1_predict_license_plate")
  Future<CarDetailsResponse> carDetailsRequest(@Part() File file);

  @GET("/{id}/?format=json")
  Future<LicenseDetailsResponse> getLicenseDetail(@Path("id") String id);
}
