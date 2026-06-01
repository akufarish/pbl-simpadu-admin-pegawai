import 'package:admin_pegawai/models/pegawai.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifikasi.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class VerifikasiResponse {
  final String id;
  @JsonKey(name: "field_name")
  final String fieldName;
  @JsonKey(name: "old_value")
  final String? oldValue;
  @JsonKey(name: "new_value")
  final String? newValue;
  final String status;
  @JsonKey(name: "employee_id")
  final String employeeId;
  final PegawaiResponse employee;

  VerifikasiResponse({
    required this.id,
    required this.fieldName,
    this.oldValue,
    this.newValue,
    required this.status,
    required this.employeeId,
    required this.employee,
  });

  factory VerifikasiResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifikasiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifikasiResponseToJson(this);
}
