import 'package:admin_pegawai_bloc/features/pegawai/data/model/pegawai_model.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/entities/verifikasi_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifikasi_model.g.dart';

@JsonSerializable(explicitToJson: true)
@PegawaiConverter()
class VerifikasiModel extends VerifikasiEntity {
  VerifikasiModel({
    required super.id,
    @JsonKey(name: "field_name") required super.fieldName,
    @JsonKey(name: "old_value") super.oldValue,
    @JsonKey(name: "new_value") super.newValue,
    required super.status,
    @JsonKey(name: "employee_id") required super.employeeId,
    required super.employee,
  });

  factory VerifikasiModel.fromJson(Map<String, dynamic> json) =>
      _$VerifikasiModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifikasiModelToJson(this);
}

class PegawaiConverter
    extends JsonConverter<PegawaiResponseEntity, Map<String, dynamic>> {
  const PegawaiConverter();

  @override
  PegawaiResponseEntity fromJson(Map<String, dynamic> json) {
    return PegawaiResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PegawaiResponseEntity object) {
    if (object is PegawaiResponse) return object.toJson();

    return {
      "id": object.id,
      "nip": object.nip,
      "nik": object.nik,
      "employee_name": object.employeeName,
      "birth_date": object.birthDate,
      "birth_place": object.birthPlace,
      "gender": object.gender,
      "address": object.address,
      "phone_number": object.phoneNumber,
      "village_code": object.villageCode,
      "district_code": object.districtCode,
      "city_code": object.cityCode,
      "province_code": object.provinceCode,
      "village": object.village,
      "district": object.district,
      "city": object.city,
      "province": object.province,
    };
  }
}

@JsonSerializable()
class UpdateVerifikasiRequest extends UpdateVerifikasiRequestEntity {
  UpdateVerifikasiRequest(super.status);

  factory UpdateVerifikasiRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVerifikasiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateVerifikasiRequestToJson(this);
}
