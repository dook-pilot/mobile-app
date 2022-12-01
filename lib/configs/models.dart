import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class CarDetailsResponse {
  bool? status;
  String? errMsg;
  CarDetailsModel? license_plate_company_data;
  List<LicenseDetailsModel?>? license_numbers_data;

  CarDetailsResponse(this.status, this.errMsg, this.license_plate_company_data, this.license_numbers_data);

  factory CarDetailsResponse.fromJson(Map<String, dynamic> json) => _$CarDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CarDetailsResponseToJson(this);
}

@JsonSerializable()
class CarDetailsModel {
  bool? status;
  String? errMsg;
  String? place_api_company_name;
  String? KVK_found;
  String? Bovag_registered;
  String? duplicates_found;
  String? rating;
  List<String?>? license_number;

  CarDetailsModel(this.status, this.errMsg, this.place_api_company_name, this.KVK_found, this.Bovag_registered, this.duplicates_found, this.rating, this.license_number);

  factory CarDetailsModel.fromJson(Map<String, dynamic> json) => _$CarDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarDetailsModelToJson(this);
}

@JsonSerializable()
class LicenseDetailsModel {
  bool? status;
  String? errMsg;
  String? title;
  String? car_company;
  String? car_model;
  List<CategoryModel>? categories;

  LicenseDetailsModel(this.status, this.errMsg, this.title, this.car_company, this.car_model, this.categories);

  factory LicenseDetailsModel.fromJson(Map<String, dynamic> json) => _$LicenseDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseDetailsModelToJson(this);
}

@JsonSerializable()
class CategoryModel {
  String title;
  List<SectionModel> sections;

  CategoryModel(this.title, this.sections);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class SectionModel {
  String title;
  List<SectionDataModel> data;

  SectionModel(this.title, this.data);

  factory SectionModel.fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectionModelToJson(this);
}

@JsonSerializable()
class SectionDataModel {
  String? col1;
  String? col2;
  String? col3;
  String? col4;
  String? info;

  SectionDataModel(this.col1, this.col2, this.col3, this.info);

  factory SectionDataModel.fromJson(Map<String, dynamic> json) => _$SectionDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectionDataModelToJson(this);
}