// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pegawai_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PegawaiResponse _$PegawaiResponseFromJson(Map<String, dynamic> json) =>
    PegawaiResponse(
      id: json['id'] as String,
      nip: json['nip'] as String,
      nik: json['nik'] as String,
      employeeName: json['employee_name'] as String,
      address: json['address'] as String?,
      birthDate: json['birth_date'] as String?,
      birthPlace: json['birth_place'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phone_number'] as String?,
      villageCode: json['village_code'] as String?,
      districtCode: json['district_code'] as String?,
      cityCode: json['city_code'] as String?,
      provinceCode: json['province_code'] as String?,
      village: const DomisiliConverter().fromJson(
        json['village'] as Map<String, dynamic>?,
      ),
      district: const DomisiliConverter().fromJson(
        json['district'] as Map<String, dynamic>?,
      ),
      city: const DomisiliConverter().fromJson(
        json['city'] as Map<String, dynamic>?,
      ),
      province: const DomisiliConverter().fromJson(
        json['province'] as Map<String, dynamic>?,
      ),
    );

Map<String, dynamic> _$PegawaiResponseToJson(PegawaiResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nip': instance.nip,
      'nik': instance.nik,
      'employee_name': instance.employeeName,
      'address': instance.address,
      'birth_place': instance.birthPlace,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
      'phone_number': instance.phoneNumber,
      'village_code': instance.villageCode,
      'district_code': instance.districtCode,
      'city_code': instance.cityCode,
      'province_code': instance.provinceCode,
      'village': const DomisiliConverter().toJson(instance.village),
      'district': const DomisiliConverter().toJson(instance.district),
      'city': const DomisiliConverter().toJson(instance.city),
      'province': const DomisiliConverter().toJson(instance.province),
    };

Domisili _$DomisiliFromJson(Map<String, dynamic> json) => Domisili(
  id: json['id'] as String,
  code: json['code'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$DomisiliToJson(Domisili instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
};

PegawaiCount _$PegawaiCountFromJson(Map<String, dynamic> json) =>
    PegawaiCount(totalEmployee: (json['total_employee'] as num).toInt());

Map<String, dynamic> _$PegawaiCountToJson(PegawaiCount instance) =>
    <String, dynamic>{'total_employee': instance.totalEmployee};

PegawaiRequest _$PegawaiRequestFromJson(Map<String, dynamic> json) =>
    PegawaiRequest(
      nip: json['nip'] as String,
      nik: json['nik'] as String,
      employeeName: json['employee_name'] as String,
      citizenCode: json['citizen_code'] as String,
    );

Map<String, dynamic> _$PegawaiRequestToJson(PegawaiRequest instance) =>
    <String, dynamic>{
      'nip': instance.nip,
      'nik': instance.nik,
      'employee_name': instance.employeeName,
      'citizen_code': instance.citizenCode,
    };
