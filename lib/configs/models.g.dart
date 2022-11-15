// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarDetailsResponse _$CarDetailsResponseFromJson(Map<String, dynamic> json) =>
    CarDetailsResponse(
      json['license_plate_company_data'] == null
          ? null
          : CarDetailsModel.fromJson(
              json['license_plate_company_data'] as Map<String, dynamic>),
      (json['license_numbers_data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : LicenseDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarDetailsResponseToJson(CarDetailsResponse instance) =>
    <String, dynamic>{
      'license_plate_company_data': instance.license_plate_company_data,
      'license_numbers_data': instance.license_numbers_data,
    };

CarDetailsModel _$CarDetailsModelFromJson(Map<String, dynamic> json) =>
    CarDetailsModel(
      json['place_api_company_name'] as String?,
      json['KVK_found'] as String?,
      json['Bovag_registered'] as String?,
      json['duplicates_found'] as String?,
      json['rating'] as String?,
      (json['license_number'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$CarDetailsModelToJson(CarDetailsModel instance) =>
    <String, dynamic>{
      'place_api_company_name': instance.place_api_company_name,
      'KVK_found': instance.KVK_found,
      'Bovag_registered': instance.Bovag_registered,
      'duplicates_found': instance.duplicates_found,
      'rating': instance.rating,
      'license_number': instance.license_number,
    };

LicenseDetailsModel _$LicenseDetailsModelFromJson(Map<String, dynamic> json) =>
    LicenseDetailsModel(
      json['title'] as String?,
      json['status'] as int?,
      json['error'] as String?,
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LicenseDetailsModelToJson(
        LicenseDetailsModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'status': instance.status,
      'error': instance.error,
      'categories': instance.categories,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['title'] as String,
      (json['sections'] as List<dynamic>)
          .map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'sections': instance.sections,
    };

SectionModel _$SectionModelFromJson(Map<String, dynamic> json) => SectionModel(
      json['title'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => SectionDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SectionModelToJson(SectionModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'data': instance.data,
    };

SectionDataModel _$SectionDataModelFromJson(Map<String, dynamic> json) =>
    SectionDataModel(
      json['col1'] as String?,
      json['col2'] as String?,
      json['col3'] as String?,
      json['info'] as String?,
    )..col4 = json['col4'] as String?;

Map<String, dynamic> _$SectionDataModelToJson(SectionDataModel instance) =>
    <String, dynamic>{
      'col1': instance.col1,
      'col2': instance.col2,
      'col3': instance.col3,
      'col4': instance.col4,
      'info': instance.info,
    };
