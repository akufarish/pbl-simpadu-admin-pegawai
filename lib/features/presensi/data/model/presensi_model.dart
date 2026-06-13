import 'package:admin_pegawai_bloc/features/presensi/domain/entities/presensi_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'presensi_model.g.dart';

@JsonSerializable()
class PresensiPegawai extends PresensiPegawaiEntity {
  PresensiPegawai({
    @JsonKey(name: "detail_id") required super.detailId,
    required super.name,
    required super.email,
    required super.status,
  });

  factory PresensiPegawai.fromJson(Map<String, dynamic> json) =>
      _$PresensiPegawaiFromJson(json);

  Map<String, dynamic> toJson() => _$PresensiPegawaiToJson(this);
}

@JsonSerializable()
class Presensi extends PresensiEntity {
  @PegawaiListConverter()
  @override
  final List<PresensiPegawai>? pegawai;

  Presensi({
    @JsonKey(name: "sesi_id") required super.sesiId,
    this.pegawai,
    @JsonKey(name: "created_at") required super.createdAt,
  }) : super(pegawai: pegawai);

  factory Presensi.fromJson(Map<String, dynamic> json) =>
      _$PresensiFromJson(json);

  Map<String, dynamic> toJson() => _$PresensiToJson(this);
}

class PegawaiListConverter
    extends JsonConverter<List<PresensiPegawai>?, List<dynamic>?> {
  const PegawaiListConverter();

  @override
  List<PresensiPegawai>? fromJson(List<dynamic>? json) {
    if (json == null) return null;
    return json
        .map((e) => PresensiPegawai.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic>? toJson(List<PresensiPegawai>? object) {
    if (object == null) return null;
    return object.map((e) => e.toJson()).toList();
  }
}

@JsonSerializable()
class PresensiResponse extends PresensiResponseEntity {
  @PresensiEntityConverter()
  @override
  final List<Presensi> items;
  PresensiResponse(this.items) : super(items);

  factory PresensiResponse.fromJson(Map<String, dynamic> json) =>
      _$PresensiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PresensiResponseToJson(this);
}

class PresensiEntityConverter
    extends JsonConverter<List<Presensi>?, List<dynamic>?> {
  const PresensiEntityConverter();

  @override
  List<Presensi>? fromJson(List<dynamic>? json) {
    if (json == null) return null;
    return json
        .map((e) => Presensi.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic>? toJson(List<Presensi>? object) {
    if (object == null) return null;
    return object.map((e) => e.toJson()).toList();
  }
}
