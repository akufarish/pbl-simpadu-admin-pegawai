// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifikasi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifikasiResponse _$VerifikasiResponseFromJson(Map<String, dynamic> json) =>
    VerifikasiResponse(
      id: json['id'] as String,
      fieldName: json['field_name'] as String,
      oldValue: json['old_value'] as String?,
      newValue: json['new_value'] as String?,
      status: json['status'] as String,
      employeeId: json['employee_id'] as String,
      employee: PegawaiResponse.fromJson(
        json['employee'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$VerifikasiResponseToJson(VerifikasiResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field_name': instance.fieldName,
      'old_value': instance.oldValue,
      'new_value': instance.newValue,
      'status': instance.status,
      'employee_id': instance.employeeId,
      'employee': instance.employee.toJson(),
    };
