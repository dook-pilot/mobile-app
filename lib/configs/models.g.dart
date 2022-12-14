// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) =>
    FileUploadResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$FileUploadResponseToJson(FileUploadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

HistoryResponse _$HistoryResponseFromJson(Map<String, dynamic> json) =>
    HistoryResponse(
      json['status'] as bool?,
      message: json['message'] as String?,
    )..documents = (json['documents'] as List<dynamic>?)
        ?.map((e) => HistoryModel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$HistoryResponseToJson(HistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'documents': instance.documents,
    };

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      json['id'] as String,
    )
      ..title = json['title'] as String?
      ..image = json['image'] as String?
      ..datetime = json['datetime'] as String?
      ..latitude = json['latitude'] as String?
      ..longitude = json['longitude'] as String?
      ..isProcessed = json['isProcessed'] as bool?;

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'datetime': instance.datetime,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isProcessed': instance.isProcessed,
    };

CarDetailsResponse _$CarDetailsResponseFromJson(Map<String, dynamic> json) =>
    CarDetailsResponse(
      json['status'] as bool?,
      json['errMsg'] as String?,
      (json['lat'] as num?)?.toDouble(),
      (json['lng'] as num?)?.toDouble(),
      json['selectedFilePath'] as String?,
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
      'status': instance.status,
      'errMsg': instance.errMsg,
      'lat': instance.lat,
      'lng': instance.lng,
      'selectedFilePath': instance.selectedFilePath,
      'license_plate_company_data': instance.license_plate_company_data,
      'license_numbers_data': instance.license_numbers_data,
    };

CarDetailsModel _$CarDetailsModelFromJson(Map<String, dynamic> json) =>
    CarDetailsModel(
      json['status'] as bool?,
      json['errMsg'] as String?,
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
      'status': instance.status,
      'errMsg': instance.errMsg,
      'place_api_company_name': instance.place_api_company_name,
      'KVK_found': instance.KVK_found,
      'Bovag_registered': instance.Bovag_registered,
      'duplicates_found': instance.duplicates_found,
      'rating': instance.rating,
      'license_number': instance.license_number,
    };

LicenseDetailsModel _$LicenseDetailsModelFromJson(Map<String, dynamic> json) =>
    LicenseDetailsModel(
      json['status'] as bool?,
      json['errMsg'] as String?,
      json['title'] as String?,
      json['car_company'] as String?,
      json['car_model'] as String?,
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LicenseDetailsModelToJson(
        LicenseDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errMsg': instance.errMsg,
      'title': instance.title,
      'car_company': instance.car_company,
      'car_model': instance.car_model,
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
