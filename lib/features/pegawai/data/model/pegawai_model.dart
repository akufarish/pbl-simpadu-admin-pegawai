import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pegawai_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DomisiliConverter()
class PegawaiResponse extends PegawaiResponseEntity {
  PegawaiResponse({
    required super.id,
    required super.nip,
    required super.nik,
    @JsonKey(name: "employee_name") required super.employeeName,
    super.address,
    @JsonKey(name: "birth_date") super.birthDate,
    @JsonKey(name: "birth_place") super.birthPlace,
    super.gender,
    @JsonKey(name: "phone_number") super.phoneNumber,
    @JsonKey(name: "village_code") super.villageCode,
    @JsonKey(name: "district_code") super.districtCode,
    @JsonKey(name: "city_code") super.cityCode,
    @JsonKey(name: "province_code") super.provinceCode,

    super.village,
    super.district,
    super.city,
    super.province,
  });

  factory PegawaiResponse.fromJson(Map<String, dynamic> json) =>
      _$PegawaiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PegawaiResponseToJson(this);
}

@JsonSerializable()
class Domisili extends DomisiliEntity {
  Domisili({required super.id, required super.code, required super.name});

  factory Domisili.fromJson(Map<String, dynamic> json) =>
      _$DomisiliFromJson(json);

  Map<String, dynamic> toJson() => _$DomisiliToJson(this);
}

@JsonSerializable()
class PegawaiCount extends PegawaiCountEntity {
  PegawaiCount({@JsonKey(name: "total_employee") required super.totalEmployee});

  factory PegawaiCount.fromJson(Map<String, dynamic> json) =>
      _$PegawaiCountFromJson(json);

  Map<String, dynamic> toJson() => _$PegawaiCountToJson(this);
}

class DomisiliConverter
    extends JsonConverter<DomisiliEntity?, Map<String, dynamic>?> {
  const DomisiliConverter();

  @override
  DomisiliEntity? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Domisili.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DomisiliEntity? object) {
    if (object == null) return null;
    if (object is Domisili) return object.toJson();

    return {"id": object.id, "code": object.code, "name": object.name};
  }
}
