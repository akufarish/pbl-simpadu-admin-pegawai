// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presensi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresensiPegawai _$PresensiPegawaiFromJson(Map<String, dynamic> json) =>
    PresensiPegawai(
      detailId: json['detail_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PresensiPegawaiToJson(PresensiPegawai instance) =>
    <String, dynamic>{
      'detail_id': instance.detailId,
      'name': instance.name,
      'email': instance.email,
      'status': instance.status,
    };

Presensi _$PresensiFromJson(Map<String, dynamic> json) => Presensi(
  sesiId: json['sesi_id'] as String,
  pegawai: const PegawaiListConverter().fromJson(json['pegawai'] as List?),
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$PresensiToJson(Presensi instance) => <String, dynamic>{
  'sesi_id': instance.sesiId,
  'created_at': instance.createdAt,
  'pegawai': const PegawaiListConverter().toJson(instance.pegawai),
};

PresensiResponse _$PresensiResponseFromJson(Map<String, dynamic> json) =>
    PresensiResponse(
      (json['items'] as List<dynamic>)
          .map((e) => Presensi.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PresensiResponseToJson(PresensiResponse instance) =>
    <String, dynamic>{'items': instance.items};
