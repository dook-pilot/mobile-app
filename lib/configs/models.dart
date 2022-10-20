import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class CarDetailsResponse {
  String? place_api_company_name;
  String? KVK_found;
  String? Bovag_registered;
  String? duplicates_found;
  String? rating;
  List<String?>? license_number;

  CarDetailsResponse(this.place_api_company_name, this.KVK_found, this.Bovag_registered, this.duplicates_found, this.rating, this.license_number);

  factory CarDetailsResponse.fromJson(Map<String, dynamic> json) => _$CarDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CarDetailsResponseToJson(this);
}

@JsonSerializable()
class LicenseDetailsResponse {
  int? status;
  List<CategoryModel>? categories;

  LicenseDetailsResponse(this.status, this.categories);

  factory LicenseDetailsResponse.fromJson(Map<String, dynamic> json) => _$LicenseDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseDetailsResponseToJson(this);
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