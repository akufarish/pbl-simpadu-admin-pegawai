import 'package:admin_pegawai_bloc/features/pegawai/data/model/pegawai_model.dart';

class PegawaiResponseEntity {
  final String id;
  final String nip;
  final String nik;
  final String employeeName;
  final String? address;
  final String? birthPlace;
  final String? birthDate;
  final String? gender;
  final String? phoneNumber;
  final String? villageCode;
  final String? districtCode;
  final String? cityCode;
  final String? provinceCode;

  final DomisiliEntity? village;
  final DomisiliEntity? district;
  final DomisiliEntity? city;
  final DomisiliEntity? province;

  PegawaiResponseEntity({
    required this.id,
    required this.nip,
    required this.nik,
    required this.employeeName,
    this.address,
    this.birthDate,
    this.birthPlace,
    this.gender,
    this.phoneNumber,
    this.village,
    this.villageCode,
    this.district,
    this.districtCode,
    this.city,
    this.cityCode,
    this.province,
    this.provinceCode,
  });
}

class DomisiliEntity {
  final String id;
  final String code;
  final String name;

  DomisiliEntity({required this.id, required this.code, required this.name});
}

class PegawaiCountEntity {
  final int totalEmployee;

  PegawaiCountEntity({required this.totalEmployee});
}

class PegawaiRequestEntity {
  final String nip;
  final String nik;
  final String employeeName;
  final String citizenCode;

  PegawaiRequestEntity({
    required this.nip,
    required this.nik,
    required this.employeeName,
    required this.citizenCode,
  });

  PegawaiRequest toModel() {
    return PegawaiRequest(
      nip: nip,
      nik: nik,
      employeeName: employeeName,
      citizenCode: citizenCode,
    );
  }
}
