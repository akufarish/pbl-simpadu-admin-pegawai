import 'package:admin_pegawai/models/pegawai.dart';
import 'package:flutter/cupertino.dart';

class VerifikasiResponse {
  final String id;
  final String fieldName;
  final String? oldValue;
  final String? newValue;
  final String status;
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

  factory VerifikasiResponse.fromJson(Map<String, dynamic> json) {
    debugPrint("Data verifikasi list");

    return VerifikasiResponse(
      id: json["id"],
      employeeId: json["employee_id"],
      fieldName: json["field_name"],
      oldValue: json["old_value"]?.toString(),
      newValue: json["new_value"]?.toString(),
      status: json["status"],
      employee: PegawaiResponse.fromJson(json["employee"] ?? {}),
    );
  }
}
